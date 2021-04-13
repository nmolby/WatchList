//
//  ActorDetailView.swift
//  WatchList
//
//  Created by Nathan Molby on 3/30/21.
//

import Foundation
import SwiftUI
import Combine

struct ActorDetailView: View {
    internal let actor: Cast
    @State internal var person: Person?
    @State internal var contentCredits: [PersonCredits.Cast] = []
    @Environment(\.managedObjectContext) private var viewContext

    let api = MovieDBAPI(apiKey: APIKey.apiKey)
    @State private var cancellables: Set<AnyCancellable> = []

    var body: some View {
        ScrollView {
            Text(person?.name ?? "")
                .font(.title)
            HStack {
                if let profilePath = actor.profilePath {
                    AsyncImage(
                        url: URL(string: "https://image.tmdb.org/t/p/w185" + profilePath)!,
                        placeholder: {Text("") },
                        image: { Image(uiImage: $0)}
                    )
                }
                Spacer()
                Text(person?.biography ?? "")
                    .font(.callout)
                    .lineLimit(6)
                    .multilineTextAlignment(.trailing)
            }
            ForEach(contentCredits, id: \.self.id) { content in
                NavigationLink(destination:
                                MovieDetailView(movie: MovieClass.createFromCastResult(movieResult: content, context: viewContext))) {
                    ContentListViewItem(result: content)
                }
            }
        }.onAppear() {
            getPerson()
        }
    }
    
    func getPerson()  {
        api.person(id: actor.id).sink { (_) in

        } receiveValue: { person in
            self.person = person
            api.personCredits(id: person.id).sink { (result) in
                print(result)
            } receiveValue: { credits in
                self.contentCredits = credits.cast
                if let crewCredits = credits.crew {
                    self.contentCredits += crewCredits
                }
            }.store(in: &cancellables)
        }.store(in: &cancellables)
    }
}

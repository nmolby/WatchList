//
//  PersonDetailView.swift
//  WatchList
//
//  Created by Nathan Molby on 4/22/21.
//

import SwiftUI
import Combine
import Foundation

struct ActorDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchList.name, ascending: true)],
        animation: .default)
    private var actors: FetchedResults<Actor>

    @ObservedObject internal var actor: ActorClass
    @State internal var contentCredits: [PersonCredits.Cast] = []
    
    let api = MovieDBAPI(apiKey: APIKey.apiKey)
    @State private var cancellables: Set<AnyCancellable> = []

    var body: some View {
        ScrollView {
            Text(actor.name ?? "")
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
                VStack {
                    Text(actor.biography ?? "")
                        .font(.callout)
                        .lineLimit(6)
                        .multilineTextAlignment(.trailing)
                    if(actor.actor != nil) {
                        Button("Remove Actor From Favorites") {
                            actor.removeFromViewContext(context: viewContext)
                        }
                    } else {
                        Button("Favorite Actor") {
                            actor.addToViewContext(context: viewContext)
                        }
                    }

                }

            }
            ForEach(contentCredits, id: \.self.id) { content in
                NavigationLink(destination:
                                MovieDetailView(movie: MovieClass.createFromCastResult(movieResult: content, context: viewContext))) {
                    ContentListViewItem(result: content)
                }
            }
        }
        .onAppear() {
            getContentCredits()
        }
    }
    
    func getContentCredits()  {
        api.personCredits(id: Int(actor.id)).sink { (result) in
            print(result)
        } receiveValue: { credits in
            self.contentCredits = credits.cast
            if let crewCredits = credits.crew {
                self.contentCredits += crewCredits
            }
        }.store(in: &cancellables)
    }
}

//
//  PersonDetailView.swift
//  WatchList
//
//  Created by Nathan Molby on 4/22/21.
//

import SwiftUI
import Combine
import Foundation

struct PersonDetailView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State internal var actor: Actor
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
                    Button("Favorite Actor") {
                        favoriteActor()
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
    
    func favoriteActor() {
        do {
            try viewContext.save()
        } catch {
            print("save failed, error \(error)")
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

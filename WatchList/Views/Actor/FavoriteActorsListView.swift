//
//  FavoriteActorsListView.swift
//  WatchList
//
//  Created by Nathan Molby on 4/22/21.
//

import SwiftUI

struct FavoriteActorsListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchList.name, ascending: true)],
        animation: .default)
    private var actors: FetchedResults<Actor>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(actors) { actor in
                    NavigationLink(destination: ActorDetailView(actor: ActorClass(actor: actor))) {
                        ActorListItemView(actor: actor)
                    }
                }
            }
            .navigationBarTitle("Favorite Actors", displayMode: .inline)
        }


    }
}

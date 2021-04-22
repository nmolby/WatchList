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
        VStack {
            ForEach(actors) { actor in
                Text((actor as Actor).name ?? "no name")
            }
        }

    }
}

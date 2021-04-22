//
//  AddToWatchListView.swift
//  WatchList
//
//  Created by Nathan Molby on 4/8/21.
//

import SwiftUI

struct AddToWatchListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchList.name, ascending: true)],
        animation: .default)
    private var watchLists: FetchedResults<WatchList>
    
    internal var movieToAdd: MovieClass
    
    var body: some View {
        List {
            ForEach(watchLists) { watchList in
                AddToWatchListButtonView(watchList: (watchList as WatchList), movieToAdd: movieToAdd)
                    .padding()
            }
        }
        .animation(.linear)

        .listStyle(GroupedListStyle())
        .navigationBarTitle("Watch Lists", displayMode: .large)
    }
    
}

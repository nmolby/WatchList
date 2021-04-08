//
//  AddToWatchListView.swift
//  WatchList
//
//  Created by Nathan Molby on 4/8/21.
//

import SwiftUI

struct AddToWatchListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchList.name, ascending: true)],
        animation: .default)
    private var watchLists: FetchedResults<WatchList>
    
    internal var movieToAdd: MovieClass
    
    var body: some View {
        ForEach(watchLists) { watchList in
            if((watchList as WatchList).containsMovie(movie: movieToAdd) ) {
                Button("Remove Movie") {
                    removeFromWatchList(watchList: (watchList as WatchList))
                }
            } else {
                Button("Add Movie") {
                    addToWatchList(watchList: (watchList as WatchList))
                }
            }
        }
    }
    
    func addToWatchList(watchList: WatchList) {
        watchList.addToMovies(movieToAdd)
        do {
            try viewContext.save()
        } catch {
            print("save failed, error \(error)")
        }
    }
    
    func removeFromWatchList(watchList: WatchList) {
        watchList.removeFromMovies(movieToAdd)
        do {
            try viewContext.save()
        } catch {
            print("save failed, error \(error)")
        }
    }
}

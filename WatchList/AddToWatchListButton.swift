//
//  AddToWatchListView.swift
//  WatchList
//
//  Created by Nathan Molby on 3/2/21.
//

import Foundation
import SwiftUI
import Combine
import CoreData

/// FIXME: save failing

struct AddToWatchListButton: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchList.name, ascending: true)],
        animation: .default)
    private var watchLists: FetchedResults<WatchList>
    
    @State private var watchList: WatchList?
    @ObservedObject internal var movie: MovieClass
    
    var movieInWatchList: Bool {
        if let watchList = watchList {
            if let movies = watchList.movies, movies.contains(movie) {
                return true
            }
        }
        return false

    }
    
    var body: some View {
        Group {
            if movieInWatchList {
                Button("Remove from watch list", action: removeFromWatchList)
            } else {
                Button("Add to watch list", action: addToWatchList)
            }
        }.onAppear() {
            getWatchList()
        }
    }
    
    func addToWatchList() {
        watchList!.addToMovies(movie)
        do {
            try viewContext.save()
        } catch {
            print("save failed")
        }
    }
    
    func removeFromWatchList() {
        watchList!.removeFromMovies(movie)
        do {
            try viewContext.save()
        } catch {
            print("save failed")
        }
    }
    
    func getWatchList() {
        for myWatchList in watchLists {
            if myWatchList.name == "Watch List"{
                watchList = myWatchList
            }
        }
        
    }
}

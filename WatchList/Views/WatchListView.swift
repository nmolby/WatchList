//
//  WatchListView.swift
//  WatchList
//
//  Created by Nathan Molby on 3/2/21.
//

import Foundation
import SwiftUI
import CoreData

struct WatchListView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchList.name, ascending: true)],
        animation: .default)
    private var watchLists: FetchedResults<WatchList>
    
    @State private var movies: [SearchResult] = []
    
    var body: some View {
        NavigationView {
            VStack {
                ContentListView(results: $movies)
            }
        }
        .navigationBarTitle("Movies", displayMode: .inline)
        .onAppear() {
            getWatchList()
        }
    }
    
    func getWatchList() {
        movies = []
        for myWatchList in watchLists {
            if myWatchList.name == "Watch List"{
                for movie in myWatchList.movies! {
                    movies.append(movie as! SearchResult)
                }
            }
        }
    }
}

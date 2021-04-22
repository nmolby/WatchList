//
//  ContentView.swift
//  WatchList
//
//  Created by David M Reed on 2/13/21.
//

import SwiftUI
import Combine
import CoreData

extension MovieSearch.Result: Identifiable { }
extension TVSearch.Result: Identifiable { }
extension Cast: Identifiable {}
extension PersonCredits.Cast: Identifiable {}

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchList.name, ascending: true)],
        animation: .default)
    private var watchLists: FetchedResults<WatchList>
    
    @State private var watchListToShow: WatchList = WatchList()

    
    var body: some View {
        TabView {
            SearchView()
                .tabItem { Image(systemName: "magnifyingglass") }
                .tag("Search View")
            WatchListsView(watchListToShow: $watchListToShow)
                .tabItem { Image(systemName: "rectangle.stack") }
                .tag("Watchlist View")
            FavoriteActorsListView()
                .tabItem { Image(systemName: "person.crop.circle")}
                .tag("Favorite Actor View")
        }
        .onAppear() {
            onAppear()
        }
    }
    
    func onAppear() {
        if !UserDefaults.standard.bool(forKey: "didLaunchBefore") {
            UserDefaults.standard.set(true, forKey: "didLaunchBefore")
            if (watchLists.count == 0) {
                let watchList = WatchList(context: viewContext)
                watchList.id = UUID()
                
                watchList.name = "Watch List"
                watchList.hasReviews = false
                watchList.movieReviews = []
                
                do {
                    try viewContext.save()
                } catch {
                    print("save failed")
                }
            }
            if (watchLists.count == 1) {
                let watchList = WatchList(context: viewContext)
                watchList.id = UUID()
                watchList.name = "Watched List"
                watchList.movieReviews = []
                
                do {
                    try viewContext.save()
                } catch {
                    print("save failed")
                }
            }
            
            for watchList in watchLists {
                if(watchList.name == "Watch List") {
                    watchListToShow = watchList
                }
            }
        }
        else {
            watchListToShow = watchLists[0]
        }
        print(watchLists.count)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

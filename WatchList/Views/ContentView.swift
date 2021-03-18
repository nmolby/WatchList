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
    
    var body: some View {
        TabView {
            SearchView()
                .tabItem { Image(systemName: "magnifyingglass") }
            
        }.onAppear() {
            if (watchLists.count == 0) {
                let watchList = WatchList(context: viewContext)
                watchList.id = UUID()
                
                watchList.name = "Watch List"
                watchList.movies = []
                
                do {
                    try viewContext.save()
                } catch {
                    print("save failed")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

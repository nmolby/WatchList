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

    var body: some View {
        TabView {
            SearchView()
                .tabItem { Image(systemName: "magnifyingglass") }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

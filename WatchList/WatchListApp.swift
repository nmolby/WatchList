//
//  WatchListApp.swift
//  WatchList
//
//  Created by David M Reed on 2/13/21.
//

import SwiftUI

@main
struct WatchListApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

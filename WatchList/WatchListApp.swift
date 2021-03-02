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
    @Environment(\.scenePhase) var scenePhase

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            
            case .background:
                do {
                    try persistenceController.container.viewContext.save()
                } catch {
                    print("error saving")
                }
            case .inactive:
                break
            case.active:
                break
            @unknown default:
                break
            }
            
        }
    }
}

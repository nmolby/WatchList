//
//  AddWatchListView.swift
//  WatchList
//
//  Created by Nathan Molby on 4/15/21.
//

import SwiftUI

struct AddWatchListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
        
    @State private var watchListName = ""
    @State private var hasReviews = false
    @State private var state = AddWatchListViewStates.None

    internal var footerText: String {
        switch(state) {
        case .Name:
            return "The name of the watch list."
        case .Reviews:
            return "If movies added to the watch list will require comments and a rating."
        case .None:
            return ""
        }
    }
    var body: some View {
        Form {
            Section(header: Text("Watch List"), footer: Text(footerText)) {
                TextField("Watch List Name", text: $watchListName)
                    .onTapGesture {
                        state = AddWatchListViewStates.Name
                    }
                Toggle("Watch List Has Reviews", isOn: $hasReviews)
                    .onTapGesture {
                        state = AddWatchListViewStates.Reviews
                    }
                Button("Create Watchlist")
                {
                    addWatchList()
                    self.presentationMode.wrappedValue.dismiss()
                }
                .disabled(watchListName == "")
                
                Button("Cancel")
                {
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    func addWatchList() {
        let newWatchList = WatchList(context: viewContext)
        newWatchList.hasReviews = hasReviews
        newWatchList.name = watchListName
        newWatchList.id = UUID()
        
        do {
            try viewContext.save()
        } catch {
            print("save failed, error \(error)")
        }
    }
}

enum AddWatchListViewStates {
    case Name
    case Reviews
    case None
}

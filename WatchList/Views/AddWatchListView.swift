//
//  AddWatchListView.swift
//  WatchList
//
//  Created by Nathan Molby on 4/15/21.
//

import SwiftUI

struct AddWatchListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    internal var watchLists: FetchedResults<WatchList>

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

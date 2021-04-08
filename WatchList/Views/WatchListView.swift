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
    @Binding internal var watchList: WatchList
    @State private var content: [ContentType] = []
    
    var body: some View {
        VStack {
            ContentListView(results: $content)
        }
        .navigationBarTitle("Movies", displayMode: .inline)
        .onAppear() {
            getWatchList()
        }
    }
    
    func getWatchList() {
        content = []
        for pieceOfContent in watchList.movies! {
            content.append(pieceOfContent as! ContentType)
        }
    }
}

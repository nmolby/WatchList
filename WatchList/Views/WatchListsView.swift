//
//  WatchListsView.swift
//  WatchList
//
//  Created by Nathan Molby on 4/8/21.
//

import SwiftUI


struct WatchListsView: View {
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \WatchList.name, ascending: true)],
        animation: .default)
    private var watchLists: FetchedResults<WatchList>
    
    @Binding internal var watchListToShow: WatchList

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination:
                                Picker("List", selection: $watchListToShow) {
                                    ForEach(watchLists) { watchList in
                                        Text((watchList as WatchList).name ?? "")
                                            .tag(watchList as WatchList)
                                    }
                }) {
                    HStack {
                        Text(watchListToShow.name ?? "")
                            .padding()
                        Spacer()
                        Text("Change List")
                            .padding()
                    }

                }


                WatchListView(watchList: $watchListToShow)
                Spacer()
            }
        }



    }
}

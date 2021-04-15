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
    
    @State private var addingWatchList = false
    @Binding internal var watchListToShow: WatchList

    var body: some View {
        NavigationView {
            VStack {
                if watchLists.count > 4 {
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
                }
                else {
                    Picker("", selection: $watchListToShow) {
                        ForEach(watchLists) { watchList in
                            Text((watchList as WatchList).name ?? "")
                                .tag(watchList as WatchList)
                        }
                    }.labelsHidden()
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                }

                WatchListView(watchList: $watchListToShow)
                Spacer()
            }
            .navigationBarItems(
                trailing: Button(action: {addingWatchList = true}) {
                    Image(systemName: "plus")
                }
            )
            .navigationBarTitle("Watch Lists", displayMode: .inline)

        }

        .popover(isPresented: $addingWatchList) {
            AddWatchListView(watchLists: watchLists)
        }


    }
}

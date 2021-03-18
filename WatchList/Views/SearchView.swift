//
//  SearchView.swift
//  WatchList
//
//  Created by Nathan Molby on 2/28/21.
//

import Foundation
import SwiftUI
import Combine
import CoreData

struct SearchView: View {
    @State private var searchText = ""
    @State private var totalResults = 0
    @State private var results: [SearchResult] = []

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Movie name", text: $searchText,
                        onEditingChanged: { changing in
                        if !changing {
                            search(searchText)
                        }
                    })
                    Button("Search") {
                        search(searchText)
                    }
                }
                .padding()
                ContentListView(results: $results)
            }
            .navigationBarTitle("Movies", displayMode: .inline)
        }
    }

    func search(_ s: String) {
        results = []
        api.movieSearch(match: s).sink { (completion) in
        } receiveValue: { (search) in
            totalResults += search.totalResults
            results += search.results
            results.sort() { lhs, rhs in
                lhs.voteCount > rhs.voteCount
            }
        }.store(in: &cancellables)
        
        api.tvSearch(match: s).sink { (completion) in
        } receiveValue: { (search) in
            totalResults += search.totalResults
            results += search.results
            results.sort() { lhs, rhs in
                lhs.voteCount > rhs.voteCount
            }
        }.store(in: &cancellables)
    }

    let api = MovieDBAPI(apiKey: APIKey.apiKey)
    @State private var cancellables: Set<AnyCancellable> = []
}

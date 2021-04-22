//
//  TVDetailView.swift
//  WatchList
//
//  Created by Nathan Molby on 2/28/21.
//

import Foundation
import SwiftUI
import Combine
import CoreData

struct TVDetailView: View {
    @State private var cast: [Cast] = []
    @State internal var show: TVSearch.Result
    

    //var namespace: Namespace.ID

    var body: some View {
        Text(show.name)
        List {
            ForEach(cast) { p in
                Text(p.name)
            }
        }
        .navigationTitle(show.name)
        .onAppear {
            api.movieCredits(id: show.id).sink { (completion) in

            } receiveValue: { (movieCredits) in
                cast = movieCredits.cast
            }.store(in: &cancellables)
        }
    }
    
    let api = MovieDBAPI(apiKey: APIKey.apiKey)
    @State private var cancellables: Set<AnyCancellable> = []
}

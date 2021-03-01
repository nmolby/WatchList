//
//  ContentListView.swift
//  WatchList
//
//  Created by Nathan Molby on 2/28/21.
//

import Foundation
import SwiftUI
import Combine
import CoreData


struct ContentListView<ContentSearch: Sequence & RandomAccessCollection >: View where ContentSearch.Element: SearchResult {
    @Binding internal var results: ContentSearch

    var body: some View {
        List {
            ForEach(results, id: \.self.id) { result in
                NavigationLink(destination:
                                MovieCreditsView(movieID: result.id, navTitle: result.name)) {
                    HStack{
                        if let posterPath = result.posterPath {
                        AsyncImage(
                            url: URL(string: "https://image.tmdb.org/t/p/w92" + posterPath)!,
                            placeholder: {Text("Loading ...") },
                            image: { Image(uiImage: $0)}
                                ).aspectRatio(contentMode: .fit)
                        }
                        VStack(alignment: .leading){
                            Text(result.name)
                            Text(result.releaseDate.trimmingCharacters(in: .whitespacesAndNewlines))
                                .fontWeight(.thin)
                                .font(.caption)
                        }
                    }

                }
            }
            
        }
    }
}

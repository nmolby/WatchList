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


struct ContentListView: View {
    @Binding internal var results: [SearchResult]
    @Environment(\.managedObjectContext) private var viewContext
    //@Namespace private var animation

    var body: some View {
        List {
            ForEach(results, id: \.self.id) { result in
                if let movie = result as? MovieSearch.Result {
                    NavigationLink(destination:
                                    MovieDetailView(movie: MovieClass.createFromMovieResult(movieResult: movie, context: viewContext))) {
                        ContentListViewItem(result: result)
                    }
                } else if let show = result as? TVSearch.Result {
                    NavigationLink(destination:
                                    TVDetailView(show: show)) {
                        ContentListViewItem(result: result)
                    }
                } else if let movie = result as? MovieClass {
                    VStack{
                        NavigationLink(destination:
                                        MovieDetailView(movie: movie)) {
                            ContentListViewItem(result: result)
                        }
                    }
                }
            }
            
        }
    }
}

struct ContentListViewItem: View {
    @State internal var result: SearchResult
    var body: some View {
        HStack{
            if let posterPath = result.posterPath {
            AsyncImage(
                url: URL(string: "https://image.tmdb.org/t/p/w92" + posterPath)!,
                placeholder: {Text("") },
                image: { Image(uiImage: $0)}
                    ).aspectRatio(contentMode: .fit)
            //.matchedGeometryEffect(id: "Poster", in: animation)
            }
            
            VStack(alignment: .leading){
                Text(result.name)
                Text(result.releaseDate.trimmingCharacters(in: .whitespacesAndNewlines))
                    .fontWeight(.thin)
                    .font(.caption)
                RatingView(ratingPercent: Int(result.voteAverage * 10))
            }
        }
    }
}

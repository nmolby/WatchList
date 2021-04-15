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
            List {
                ForEach(watchList.movieReviews!.allObjects as! [MovieReview]) { movieReview in
                    NavigationLink(destination:
                                    MovieDetailView(movie: movieReview.movie!)) {
                        ContentListViewItem(result: movieReview.movie!)
                    }
                    if(watchList.hasReviews) {
                        StarRatingView(rating: .constant(Int(movieReview.rating)), clickable: false, maximumRating: 5)
                        Text(movieReview.comment ?? "")
                    }
                }
            }
        }

    }
}

//
//  AddToWatchListButtonView.swift
//  WatchList
//
//  Created by Nathan Molby on 4/13/21.
//

import SwiftUI

struct AddToWatchListButtonView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @State internal var comments: String = ""
    @ObservedObject internal var watchList: WatchList
    @State internal var addingMovie = false
    internal var movieToAdd: MovieClass

    var body: some View {
        
        HStack {
            Text(watchList.name ?? "")
                .font(.title)
            Spacer()
            Group {
                if (watchList as WatchList).containsMovie(movie: movieToAdd) {
                    Button("Remove Movie") {
                        removeFromWatchList(watchList: watchList)
                    }
                } else if !addingMovie {
                    Button("Add Movie") {
                        addingMovie = true
                        addToWatchList(watchList: watchList)
                    }
                }
            }
            .font(.title2)
        }
        Group {
            if(watchList.hasReviews && addingMovie) {
                TextField("Comments", text: $comments)
            }
        }

    }
    
    func addToWatchList(watchList: WatchList) {
        let movieReview = MovieReview(context: viewContext)
        movieReview.comment = ""
        movieReview.rating = 10
        movieReview.movie = movieToAdd
        movieReview.watchList = watchList
        watchList.addToMovieReviews(movieReview)
        do {
            try viewContext.save()
        } catch {
            print("save failed, error \(error)")
        }
    }
    
    func removeFromWatchList(watchList: WatchList) {
        watchList.removeFromWatchList(movie: movieToAdd, viewContext: viewContext)
        do {
            try viewContext.save()
        } catch {
            print("save failed, error \(error)")
        }
    }
}

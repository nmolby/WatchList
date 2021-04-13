//
//  WatchList.swift
//  WatchList
//
//  Created by Nathan Molby on 3/2/21.
//

import Foundation
import CoreData

extension WatchList {
    func containsMovie(movie: MovieClass) -> Bool {
        for movieReview in self.movieReviews! {
            if (movieReview as! MovieReview).movie == movie {
                return true
            }
        }
        return false
    }
    
    func removeFromWatchList(movie: MovieClass, viewContext: NSManagedObjectContext) {
        for movieReview in self.movieReviews! {
            if (movieReview as! MovieReview).movie == movie {
                (movieReview as! MovieReview).watchList = nil
                viewContext.delete(movieReview as! MovieReview)
            }
        }
        
    }
}

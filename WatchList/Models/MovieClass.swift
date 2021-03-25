//
//  MovieClass.swift
//  WatchList
//
//  Created by Nathan Molby on 3/2/21.
//

import Foundation
import CoreData

extension MovieClass {
    static func createFromMovieResult(movieResult: MovieSearch.Result, context: NSManagedObjectContext) -> MovieClass {
        let myMovieClass = MovieClass(context: context)
        myMovieClass.id = Int64(movieResult.id)
        myMovieClass.name = movieResult.name
        myMovieClass.posterPath = movieResult.posterPath
        myMovieClass.releaseDate = movieResult.releaseDate
        myMovieClass.voteAverage = movieResult.voteAverage
        myMovieClass.voteCount = Int64(movieResult.voteCount)
        myMovieClass.popularity = movieResult.popularity
        myMovieClass.overview = movieResult.overview
        return myMovieClass
    }
}

extension MovieClass {
    static func ==(lhs: MovieClass, rhs: MovieClass) -> Bool {
        return lhs.id == rhs.id
    }
}

extension MovieClass: ContentType {
    var releaseDate: String {
        get {
            return self.optionalReleaseDate ?? ""
        } set {
            self.optionalReleaseDate = newValue
        }
    }

    var name: String {
        get {
            return self.optionalName ?? ""
        } set {
            self.optionalName = newValue
        }
    }
}

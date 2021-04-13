//
//  MovieReview.swift
//  WatchList
//
//  Created by Nathan Molby on 4/13/21.
//

import Foundation

extension MovieReview {
    static func ==(lhs: MovieReview, rhs: MovieReview) -> Bool {
        return lhs.movie?.id == rhs.movie?.id
    }
}

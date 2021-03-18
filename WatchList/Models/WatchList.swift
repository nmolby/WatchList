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
        for myMovie in self.movies! {
            if myMovie as! MovieClass == movie {
                return true
            }
        }
        return false
    }
}

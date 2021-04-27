//
//  ActorListItemView.swift
//  WatchList
//
//  Created by Nathan Molby on 3/25/21.
//

import Foundation
import SwiftUI
import Combine
import CoreData


struct CastListItemView: View {
    internal let cast: Cast
    
    var body: some View {
        VStack {
            if let profilePath = cast.profilePath {
                AsyncImage(
                    url: URL(string: "https://image.tmdb.org/t/p/w185" + profilePath)!,
                    placeholder: {Text("") },
                    image: { Image(uiImage: $0)}
                )
            }
            Text(cast.name)
                .font(.title2)
            if let character = cast.character {
                Text(character).font(.title3)
            }
        }

    }
}

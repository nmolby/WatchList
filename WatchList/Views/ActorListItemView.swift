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


struct ActorListItemView: View {
    @State private var cast: [Cast] = []
    internal let actor: Cast
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
        VStack {
            if let profilePath = actor.profilePath {
                AsyncImage(
                    url: URL(string: "https://image.tmdb.org/t/p/w45" + profilePath)!,
                    placeholder: {Text("") },
                    image: { Image(uiImage: $0)}
                        ).aspectRatio(contentMode: .fit)
            }
            Text(actor.name)
            if let character = actor.character {
                Text(character).font(.footnote)
            }
        }

    }
}

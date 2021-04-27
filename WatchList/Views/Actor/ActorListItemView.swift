//
//  ActorVListItemView.swift
//  WatchList
//
//  Created by Nathan Molby on 4/22/21.
//

import SwiftUI

struct ActorListItemView: View {
    internal let actor: Actor

    var body: some View {
        HStack {
            if let profilePath = actor.profilePath {
                AsyncImage(
                    url: URL(string: "https://image.tmdb.org/t/p/w92" + profilePath)!,
                    placeholder: {Text("") },
                    image: { Image(uiImage: $0)}
                )
            }
            Spacer()
            Text(actor.name ?? "")
                .font(.title2)
        }
    }
}

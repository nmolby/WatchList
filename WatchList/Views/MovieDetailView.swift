//
//  MovieDetailView.swift
//  WatchList
//
//  Created by Nathan Molby on 2/28/21.
//

import Foundation
import SwiftUI
import Combine
import CoreData

struct MovieDetailView: View {
    @State private var cast: [Cast] = []
    @State internal var movie: MovieClass
    @Environment(\.managedObjectContext) private var viewContext

    //var namespace: Namespace.ID

    var body: some View {
        ScrollView{
            HStack{
                if let posterPath = movie.posterPath {
                AsyncImage(
                    url: URL(string: "https://image.tmdb.org/t/p/w185" + posterPath)!,
                    placeholder: {Text("") },
                    image: { Image(uiImage: $0)}
                        ).aspectRatio(contentMode: .fit)
                //.matchedGeometryEffect(id: "Poster", in: animation)
                }
                Spacer()
                VStack{
                    Text(movie.name).font(.title)
                    Text(movie.releaseDate).font(.headline)
                    Text(String(movie.popularity))
                    RatingView(ratingPercent: Int(movie.voteAverage * 10))
                    HStack {
                        AddToWatchListButton(movie: movie)
                        //AddToWatchedButton()
                    }
                }
                
            }
            ForEach(cast) { p in
                Text(p.name)
            }

        }
        .onAppear {
            api.movieCredits(id: movie.id).sink { (completion) in

            } receiveValue: { (movieCredits) in
                cast = movieCredits.cast
            }.store(in: &cancellables)
        }
        .navigationTitle(movie.name)

    }
    
    let api = MovieDBAPI(apiKey: APIKey.apiKey)
    @State private var cancellables: Set<AnyCancellable> = []
}

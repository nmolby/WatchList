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
    internal let movie: MovieClass
    @Environment(\.managedObjectContext) private var viewContext

    //var namespace: Namespace.ID
    
    //https://stackoverflow.com/a/57631177
    init(movie: MovieClass) {
        self.movie = movie
        
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 10)!]

        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 10)!]
    }
    var body: some View {
        ScrollView{
            Text(movie.name)
                .font(.title)
                //https://stackoverflow.com/a/59684944
                .fixedSize(horizontal: false, vertical: true)
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
                VStack {
                    HStack {
                        Text("Release")
                            .font(.callout)
                            .fontWeight(.light)
                        Spacer()
                        Text(movie.releaseDate)
                            .font(.callout)
                    }
                    NavigationLink(destination: Text(movie.overview!) ){
                        HStack {
                            Text("Description")
                                .font(.callout)
                                .fontWeight(.light)
                            Spacer()
                            Text(movie.overview!)
                                .font(.callout)
                                .lineLimit(4)
                                .multilineTextAlignment(.trailing)
                        }
                        
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    
                    Spacer()
                    RatingView(ratingPercent: Int(movie.voteAverage * 10))
                        .frame(height: 40)
                    HStack {
                        AddToWatchListButton(movie: movie)
                        //AddToWatchedButton()
                    }
                }
                
            }
            ScrollView(.horizontal) {
                HStack {
                    ForEach(cast) { actor in
                        ActorListItemView(actor: actor)
                    }
                }

            }


        }
        .onAppear {
            api.movieCredits(id: movie.id).sink { (completion) in

            } receiveValue: { (movieCredits) in
                cast = movieCredits.cast
            }.store(in: &cancellables)
        }
        .navigationBarTitle(movie.name)

    }
    
    let api = MovieDBAPI(apiKey: APIKey.apiKey)
    @State private var cancellables: Set<AnyCancellable> = []
}

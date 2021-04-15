//
//  StarRatingView.swift
//  WatchList
//
//  Created by Nathan Molby on 4/15/21.
//
//  adapted from https://www.hackingwithswift.com/books/ios-swiftui/adding-a-custom-star-rating-component

import SwiftUI

struct StarRatingView: View {
    @Binding internal var rating: Int
    internal var clickable: Bool
    internal var maximumRating: Int
    
    var offImage = Image(systemName: "star")
    var onImage = Image(systemName: "star.fill")

    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            ForEach(1..<maximumRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor : self.onColor)
                    .onTapGesture {
                        if(clickable) {
                            self.rating = number
                        }
                    }
            }
        }
        
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage
        } else {
            return onImage
        }
    }
}

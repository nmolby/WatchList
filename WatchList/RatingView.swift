//
//  RatingView.swift
//  WatchList
//
//  Created by Nathan Molby on 2/28/21.
//

import Foundation
import SwiftUI
import Combine
import CoreData

struct RatingView: View {
    let ratingPercent: Int
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                Rectangle()
                    .fill(Color(.red))
                HStack{
                    Rectangle()
                        .fill(Color(.green))
                        .frame(width: geometry.size.width * CGFloat(ratingPercent) / 100, alignment: .leading)
                    Spacer()
                }
                
            }
        }

    }
}

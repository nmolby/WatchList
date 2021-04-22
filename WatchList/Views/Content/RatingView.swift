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
        GeometryReader { fullGeometry in
            VStack (alignment: .leading){
                ZStack (alignment: Alignment(horizontal: .leading, vertical: .center)){
                    GeometryReader {
                        zstackGeometry in
                        Rectangle()
                            .fill(LinearGradient(gradient: Gradient(colors: [.red, .yellow, .green]), startPoint: .leading, endPoint: .trailing))
                        Rectangle()
                            .fill(Color(.white))
                            .frame(width: zstackGeometry.size.width * 0.02, height: zstackGeometry.size.height, alignment: .leading)
                            .offset(x: fullGeometry.size.width * CGFloat(ratingPercent) / 100 - zstackGeometry.size.width * 0.01)
                    }
                    
                    
                }.frame(width: fullGeometry.size.width, height: fullGeometry.size.height * 0.8, alignment: .leading)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                
                GeometryReader { imageGeometry in
                    Image(systemName: "arrowtriangle.up.fill")
                        .resizable()
                        .offset(x: -imageGeometry.size.width / 2)
                }
                .frame(width: fullGeometry.size.width * 0.1)
                .offset(x: fullGeometry.size.width * CGFloat(ratingPercent) / 100)

            }

        }

    }
}

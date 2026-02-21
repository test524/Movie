//
//  MovieCard.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 17/02/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCard: View {
    let movie: Movie
    var body: some View {
         WebImage(url: movie.posterURL!)
        .resizable()
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .aspectRatio(2/3, contentMode: .fit)
    }
}


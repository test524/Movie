//
//  ContentView.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 15/02/26.
//

import SwiftUI
import Combine

enum TabType : String , Hashable {
    case Popular = "Popular"
    case TopRated = "Top Rated"
}

struct MoviesTabView: View {
    @State private var viewModel = MovieViewModel.make()
    var body: some View {
        TabView {
            Tab("Now Playing", systemImage: "tray.and.arrow.up.fill") {
                NowPlayingView()
            }
            Tab("Upcoming", systemImage: "tray.and.arrow.up.fill") {
                UpcomingMoviesView()
            }
            Tab("Popular", systemImage: "tray.and.arrow.down.fill") {
                PopularMoviesView()
            }
            Tab("TopRated", systemImage: "tray.and.arrow.up.fill") {
                TopRatedMoviesView()
            }
        }.environment(viewModel)
    }
}


#Preview {
    MoviesTabView()
}






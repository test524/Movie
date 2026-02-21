//
//  NowPlayingView.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 17/02/26.
//

import SwiftUI

struct NowPlayingView : View {

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    @Environment(AppRouter.self) private var router
    @Environment(MovieViewModel.self) private var vm
    
    var body: some View {
        @Bindable var router = router
        NavigationStack(path:$router.nowPath) {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading) {
                    ForEach(vm.nowPlaying) { movie in
                        MovieCard(movie: movie)
                            .onTapGesture {
                                router.push(NowRoute.movieDetails(id: movie.id), to: &router.nowPath)
                            }
                    }
                }.padding()
            }.task {
                if vm.nowPlaying.isEmpty {
                    print("Api calling Now Playing.......")
                    await vm.fetchNowPlayingMovies()
                }
            }.navigationDestination(for: NowRoute.self, destination: { router in
                switch router {
                case .movieDetails(let id) :
                    //Text("\(id)")
                    MovieDetailView(movieId: id)
                        .toolbarVisibility(.hidden, for: .tabBar)
                }
            })
            .navigationTitle("Now Playing")
        }
    }
    
}

#Preview {
    NowPlayingView()
}

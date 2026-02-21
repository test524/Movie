//
//  PopularMoviesView.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 17/02/26.
//

import SwiftUI

struct PopularMoviesView : View {

    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @Environment(AppRouter.self) private var router
    @Environment(MovieViewModel.self) private var vm
    
    var body: some View {
        @Bindable var router = router
        NavigationStack(path: $router.popularPath) {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading) {
                    ForEach(vm.popular) { movie in
                        MovieCard(movie: movie)
                            .onTapGesture {
                                router.push(PopularRoute.movieDetails(id: movie.id), to: &router.popularPath)
                            }
                    }
                }.padding()
            }.task {
                if vm.popular.isEmpty {
                    print("Api calling Popluar Movies.......")
                    await vm.fetchPopularMovies()
                }
            }.navigationDestination(for: PopularRoute.self, destination: { router in
                switch router {
                case .movieDetails(let id) :
                    MovieDetailView(movieId: id)
                        .toolbarVisibility(.hidden, for: .tabBar)
                }
            }).navigationTitle("Popular")
        }
    }
    
}


#Preview {
    PopularMoviesView()
}



//
//  TopRatedMoviesView.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 17/02/26.
//

import SwiftUI


struct TopRatedMoviesView : View {
    @Environment(MovieViewModel.self) private var vm
    //Grid two items
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @Environment(AppRouter.self) private var router
    var body: some View {
        @Bindable var router = self.router
        NavigationStack(path: $router.topPath) {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading) {
                    ForEach(vm.topRated) { movie in
                        MovieCard(movie: movie)
                            .onTapGesture {
                                router.push(TopRatedRoute.movieDetails(id: movie.id), to: &router.topPath)
                            }
                    }
                }.padding()
            }.task {
                if vm.topRated.isEmpty {
                    print("Api calling Top Rated.......")
                    await vm.fetchTopRatedMovies()
                }
            }.navigationDestination(for: TopRatedRoute.self, destination: { router in
                switch router {
                case .movieDetails(let id) :
                    MovieDetailView(movieId: id)
                        .toolbarVisibility(.hidden, for: .tabBar)
                }
            }).navigationTitle("Top Rated")
        }
        
    }
}


#Preview {
    TopRatedMoviesView()
}

//
//  UpcomingMoviesView.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 17/02/26.
//

import SwiftUI

struct UpcomingMoviesView : View {
    
    @Environment(MovieViewModel.self) private var vm
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @Environment(AppRouter.self) private var router
    var body: some View {
        @Bindable var router = self.router
        NavigationStack(path: $router.upcomingPath) {
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading) {
                    ForEach(vm.upcoming) { movie in
                        MovieCard(movie: movie)
                            .onTapGesture {
                                router.push(UpComingRoute.movieDetails(id: movie.id), to: &router.upcomingPath)
                            }
                    }
                }.padding()
            }
            .task {
                if vm.upcoming.isEmpty {
                    print("Api calling UpComing.......")
                    await vm.fetchupComingMovies()
                }
            }
            .navigationDestination(for: UpComingRoute.self, destination: { router in
                switch router {
                case .movieDetails(let id) :
                    MovieDetailView(movieId: id)
                        .toolbarVisibility(.hidden, for: .tabBar)
                }
            })
            .navigationTitle("Upcoming")
        }
    }
}

#Preview {
    UpcomingMoviesView()
}

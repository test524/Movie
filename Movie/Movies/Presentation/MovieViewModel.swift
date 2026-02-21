//
//  MovieViewModel.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 15/02/26.
//

import Observation
import Foundation

@Observable
class MovieViewModel {

    var popular: [Movie] = []
    var topRated: [Movie] = []
    var nowPlaying: [Movie] = []
    var upcoming: [Movie] = []
    
    private let movieUseCase: FetchMoviesUseCaseProtocol
    private let movieDetailsUseCase: MovieDetailsUseCaseProtocol

    init(repo: FetchMoviesUseCaseProtocol, movieDetailsRepo: MovieDetailsUseCaseProtocol) {
        self.movieUseCase = repo
        self.movieDetailsUseCase = movieDetailsRepo
    }
    
    func fetchPopularMovies() async {
        do {
            let data = try await self.movieUseCase.execute(category: .popular, page: 0)
            self.popular = data.results
        }catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func fetchTopRatedMovies() async {
        do {
            let data = try await self.movieUseCase.execute(category: .topRated, page: 0)
            self.topRated = data.results
        }catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func fetchNowPlayingMovies() async {
        do {
            let data = try await self.movieUseCase.execute(category: .nowPlaying, page: 0)
            self.nowPlaying = data.results
        }catch(let error) {
            print(error.localizedDescription)
        }
    }
    
    func fetchupComingMovies() async {
        do {
            let data = try await self.movieUseCase.execute(category: .upComing, page: 0)
            self.upcoming = data.results
        }catch(let error) {
            print(error.localizedDescription)
        }
    }
    
}

extension MovieViewModel {
    static func make() -> MovieViewModel {
        let repository = MovieRepositoryImpl()
        let repoMovies: FetchMoviesUseCase = FetchMoviesUseCase(repository: repository)
        let repoMovieDetails: MovieDetailsUseCase = MovieDetailsUseCase(repository: repository)
        return MovieViewModel(repo: repoMovies, movieDetailsRepo: repoMovieDetails)
    }
}


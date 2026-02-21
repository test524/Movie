//
//  MovieRepositoryImpl.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 15/02/26.
//

import Foundation

protocol MovieRepository {
    func fetchPopularMovies(page:Int) async throws -> MovieResponse
    func fetchTopRatedMovies(page:Int) async throws -> MovieResponse
    func fetchNowPlayingMovies(page:Int) async throws -> MovieResponse
    func fetchUpcomingMovies(page:Int) async throws -> MovieResponse
    func fetchMovieDetails(id:Int) async throws -> Movie
}

class MovieRepositoryImpl: MovieRepository {
    private let networkService: NetworkServiceProtocol
    init(networkService: NetworkServiceProtocol = NetworkService.shared) {
        self.networkService = networkService
    }
    func fetchPopularMovies(page:Int) async throws -> MovieResponse {
         let popularMovies:MovieResponse = try await networkService.request(TMDBEndpoint.popular(page: page))
         return popularMovies
    }
    func fetchTopRatedMovies(page:Int) async throws -> MovieResponse {
        let topRatedMovies:MovieResponse = try await networkService.request(TMDBEndpoint.topRated(page: page))
        return topRatedMovies
    }
    func fetchNowPlayingMovies(page:Int) async throws -> MovieResponse {
        let nowPlayingMovies:MovieResponse = try await networkService.request(TMDBEndpoint.nowPlaying(page: page))
        return nowPlayingMovies
    }
    func fetchUpcomingMovies(page:Int) async throws -> MovieResponse {
        let nowPlayingMovies:MovieResponse = try await networkService.request(TMDBEndpoint.upcoming(page: page))
        return nowPlayingMovies
    }
    func fetchMovieDetails(id: Int) async throws -> Movie {
        let movie:Movie = try await networkService.request(TMDBEndpoint.movieDetail(id: id))
        return movie
    }
}


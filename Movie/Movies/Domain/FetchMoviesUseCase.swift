//
//  GetPopularMoviesUseCase.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 15/02/26.
//

import Foundation


protocol FetchMoviesUseCaseProtocol {
    func execute(category: MovieCategory, page: Int) async throws -> MovieResponse
}

final class FetchMoviesUseCase: FetchMoviesUseCaseProtocol {
    private let repository: MovieRepository
    init(repository: MovieRepository) {
        self.repository = repository
    }
    func execute(category: MovieCategory, page: Int) async throws -> MovieResponse {
        switch category {
        case .popular:
            return try await repository.fetchPopularMovies(page: page)
        case .topRated:
            return try await repository.fetchTopRatedMovies(page: page)
        case .nowPlaying:
            return try await repository.fetchNowPlayingMovies(page: page)
        case .upComing:
            return try await repository.fetchUpcomingMovies(page: page)
        }
    }
}


// MARK: - Movie Category
enum MovieCategory: String, CaseIterable, Identifiable {
    case popular       = "Popular"
    case topRated      = "TopRated"
    case nowPlaying    = "nowPlaying"
    case upComing      = "Upcoming"
    var id: String { rawValue }
    var systemImage: String {
        switch self {
        case .popular:    return "flame.fill"
        case .topRated:    return "flame.fill"
        case .nowPlaying:    return "flame.fill"
        case .upComing:    return "flame.fill"
        }
    }
}


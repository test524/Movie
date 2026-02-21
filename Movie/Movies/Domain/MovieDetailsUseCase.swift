//
//  MovieDetailsUseCase.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 17/02/26.
//

import Foundation

protocol MovieDetailsUseCaseProtocol {
    func execute(id:Int) async throws -> Movie
}

final class MovieDetailsUseCase: MovieDetailsUseCaseProtocol {
    private let repository: MovieRepository
    init(repository: MovieRepository) {
        self.repository = repository
    }
    func execute(id: Int) async throws -> Movie {
        return try await repository.fetchMovieDetails(id: id)
    }
}



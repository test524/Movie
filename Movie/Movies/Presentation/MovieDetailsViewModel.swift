//
//  MovieDetailsViewModel.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 18/02/26.
//

import Foundation

@Observable
class MovieDetailsViewModel {

    var movieDetails:Movie?

    private let movieDetailsUseCase: MovieDetailsUseCaseProtocol
    init(movieDetailsRepo: MovieDetailsUseCaseProtocol) {
        self.movieDetailsUseCase = movieDetailsRepo
    }
    
    func fetchupMovieDetails(id:Int) async {
        do {
            let data = try await self.movieDetailsUseCase.execute(id: id)
            self.movieDetails = data
        }catch(let error) {
            print(error.localizedDescription)
        }
    }
    
}

extension MovieDetailsViewModel {
    static func make() -> MovieDetailsViewModel {
        return MovieDetailsViewModel(movieDetailsRepo: MovieDetailsUseCase(repository: MovieRepositoryImpl()))
    }
}

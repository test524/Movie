//
//  MovieModel.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 15/02/26.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let results: [Movie]
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

struct Movie: Identifiable, Codable {
    let id: Int
    let title: String
    let adult: Bool
    let popularity: Double
    let voteCount:Int
    let overview: String
    let posterPath: String?
    let releaseDate:String?
    let voteAverage:Double?
    
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
    }
    
    /*var releaseYear: String? {
        guard let dateString = releaseDate else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: dateString) else { return nil }
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: date)
    }*/
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case adult
        case popularity
        case overview
        case posterPath = "poster_path"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}

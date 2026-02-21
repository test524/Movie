//
//  TMDBEndPoints.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 16/02/26.
//

import Foundation

// MARK: - Data Layer
// TMDBEndpoints.swift — TMDB API endpoint definitions

// MARK: - TMDB Configuration
enum TMDBConfig {
    static let apiKey   = "67d9ed25215952905c3d5d13514f06c2"  // 🔑 Replace with your key
    static let baseURL  = "https://api.themoviedb.org/3"
    static let language = "en-US"
}

// MARK: - TMDB Endpoints
enum TMDBEndpoint: Endpoint {

    case nowPlaying(page: Int)
    case popular(page: Int)
    case topRated(page: Int)
    case upcoming(page: Int)
    case search(query: String, page: Int)
    case movieDetail(id: Int)

    var baseURL: String { TMDBConfig.baseURL }

    var path: String {
        switch self {
        case .nowPlaying:          return "/movie/now_playing"
        case .popular:             return "/movie/popular"
        case .topRated:            return "/movie/top_rated"
        case .upcoming:            return "/movie/upcoming"
        case .search:              return "/search/movie"
        case .movieDetail(let id): return "/movie/\(id)"
        }
    }

    var method: HTTPMethod { .get }

    var queryParameters: [String: String] {
        var params: [String: String] = [
            "api_key":  TMDBConfig.apiKey
            //"language": TMDBConfig.language
        ]
        switch self {
        case .nowPlaying(let page),
             .popular(let page),
             .topRated(let page),
             .upcoming(let page):
            //params["page"] = "\(page)"
            break
        case .search(let query, let page):
            params["query"] = query
            params["page"]  = "\(page)"

        case .movieDetail:
            break
        }
        return params
    }

    var headers: [String: String] {
        ["Content-Type": "application/json"]
    }
}


//
//  ApiManager.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 15/02/26.
//

import Foundation


// MARK: - Data Layer
// NetworkService.swift — Generic HTTP client with async/await

// MARK: - Network Errors
enum NetworkError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpError(statusCode: Int)
    case decodingError(Error)
    case noInternetConnection
    case timeout
    case unknown(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:              return "The request URL is invalid."
        case .invalidResponse:         return "Received an invalid response from the server."
        case .httpError(let code):     return "HTTP error with status code \(code)."
        case .decodingError(let e):    return "Failed to decode response: \(e.localizedDescription)"
        case .noInternetConnection:    return "No internet connection. Please check your network."
        case .timeout:                 return "The request timed out. Please try again."
        case .unknown(let e):          return "An unexpected error occurred: \(e.localizedDescription)"
        }
    }
}

// MARK: - HTTP Method

enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

// MARK: - Endpoint Protocol

protocol Endpoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var queryParameters: [String: String] { get }
    var headers: [String: String] { get }
}

extension Endpoint {
    func urlRequest() throws -> URLRequest {
        guard var components = URLComponents(string: baseURL + path) else {
            throw NetworkError.invalidURL
        }
        components.queryItems = queryParameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        guard let url = components.url else { throw NetworkError.invalidURL }

        var request = URLRequest(url: url, timeoutInterval: 30)
        request.httpMethod = method.rawValue
        headers.forEach { request.setValue($1, forHTTPHeaderField: $0) }
        return request
    }
}

// MARK: - Network Service Protocol

protocol NetworkServiceProtocol {
    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T
}

// MARK: - Network Service Implementation

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    private let decoder: JSONDecoder

    static let shared = NetworkService()

    init(session: URLSession = .shared) {
        self.session = session
        self.decoder = JSONDecoder()
    }

    func request<T: Decodable>(_ endpoint: Endpoint) async throws -> T {
        let request = try endpoint.urlRequest()
        print("URL:N-",request.url!.absoluteString)
        do {
            let (data, response) = try await session.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }

            guard (200..<300).contains(httpResponse.statusCode) else {
                throw NetworkError.httpError(statusCode: httpResponse.statusCode)
            }

            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                throw NetworkError.decodingError(error)
            }
        } catch let error as NetworkError {
            throw error
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                throw NetworkError.noInternetConnection
            case .timedOut:
                throw NetworkError.timeout
            default:
                throw NetworkError.unknown(urlError)
            }
        } catch {
            throw NetworkError.unknown(error)
        }
    }
}

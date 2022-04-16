//
//  MoviesProvider.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 16/4/22.
//

import Foundation
import Combine

protocol MoviesProviderProtocol: BaseRepository {
    func loadMovies(page: Int, completionHadler: @escaping (Result<MovieProviderResponse, APIError>) -> ())
}

class MoviesProvider: MoviesProviderProtocol {

    var baseURL: String
    var session: URLSession
    var cancellable: Set<AnyCancellable>

    init(baseURL: String, session: URLSession) {
        self.baseURL = baseURL
        self.session = session
        cancellable = []

    }


    func loadMovies(page: Int, completionHadler: @escaping (Result<MovieProviderResponse, APIError>) -> ()) {
        let request: AnyPublisher<MovieProviderResponse, Error> = execute(endpoint: API.topRatedMovies(page: page), entityClass: MovieProviderResponse.self, queue: .main, retries: 1)

            request.sink { result in
                switch result {
                case .finished:
                    break
                case .failure(_):
                    completionHadler(.failure(APIError.unexpectedResponse))
                    break
                }
            } receiveValue: { resultData in
                completionHadler(.success(resultData))
            }
            .store(in: &cancellable)
    }

}

// MARK: - Endpoints

extension MoviesProvider {
    enum API {
        case topRatedMovies(page: Int)
        case movieDetails(movie: Movie, page: Int)
    }
}

extension MoviesProvider.API: APICall {

    var path: String {
        var pathAux = ""
        switch self {
        case .topRatedMovies:
            pathAux = "/top_rated"
        case let .movieDetails(movie,_):
            if  let encodedName = movie.name?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                pathAux = "/name/\(encodedName)"
            }
        }
        return pathAux
    }
    var method: String {
        switch self {
        case .movieDetails, .topRatedMovies:
            return "GET"
        }
    }

    var queryParams: [URLQueryItem]? {
        var queryParamsAux = [URLQueryItem]()
        var pageAux = 1
        switch self {
        case let .movieDetails(_,page):
            pageAux = page
        case let .topRatedMovies(page):
            pageAux = page
        }
            queryParamsAux.append(URLQueryItem(name: "page", value: "\(pageAux)"))
            queryParamsAux.append(URLQueryItem(name: "api_key", value: Constants.RepositoryConfig.apiKey))
            queryParamsAux.append(URLQueryItem(name: "language", value: Constants.RepositoryConfig.language))

        return queryParamsAux
    }

    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    func body() throws -> Data? {
        return nil
    }
}

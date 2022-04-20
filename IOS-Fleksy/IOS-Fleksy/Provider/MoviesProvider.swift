//
//  MoviesProvider.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 16/4/22.
//

import Foundation
import Combine

protocol MoviesProviderProtocol: BaseRepository {
    func loadMovies(id: Int?,page: Int, completionHadler: @escaping (Result<MovieProviderResponse, APIError>) -> ())
    func getMovie(id: Int, completionHadler: @escaping (Result<DetailMovie, APIError>) -> ())
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

    func loadMovies(id: Int? = nil, page: Int, completionHadler: @escaping (Result<MovieProviderResponse, APIError>) -> ()) {
        let api: API = ((id) != nil) ? API.getSimilarMovies(id: id, page: page) : API.topRatedMovies(page: page)

        let request: AnyPublisher<MovieProviderResponse, Error> = execute(endpoint: api, entityClass: MovieProviderResponse.self, queue: .main, retries: 1)

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

    func getMovie(id: Int, completionHadler: @escaping (Result<DetailMovie, APIError>) -> ()) {

        let request: AnyPublisher<DetailMovie, Error> = execute(endpoint: API.getDetailMovie(id: id), entityClass: DetailMovie.self, queue: .main, retries: 1)
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

extension MoviesProvider {
    enum API {
        case topRatedMovies(page: Int)
        case movieDetails(movie: Movie, page: Int)
        case getDetailMovie(id: Int)
        case getSimilarMovies(id: Int?, page: Int)
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

        case .getDetailMovie(id: let id):
            if  let encodedName = String(id).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
                pathAux = "/\(encodedName)"
            }
        case .getSimilarMovies(id: let id,_):
            if let idParam = id {
                let idAux = String(describing: idParam).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
                pathAux = "/\(idAux ?? "")/similar"
            }
        }
        return pathAux
    }
    var method: String {
        switch self {
        case .movieDetails, .topRatedMovies, .getDetailMovie, .getSimilarMovies:
            return "GET"
        }
    }

    var queryParams: [URLQueryItem]? {
        var queryParamsAux = [URLQueryItem]()
        switch self {
        case let .movieDetails(_,page):
            queryParamsAux.append(URLQueryItem(name: "page", value: "\(page)"))
        case let .topRatedMovies(page):

            queryParamsAux.append(URLQueryItem(name: "page", value: "\(page)"))
        case .getDetailMovie(id: _):
            break
        case .getSimilarMovies(_, let page):
            queryParamsAux.append(URLQueryItem(name: "page", value: "\(page)"))
        }
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

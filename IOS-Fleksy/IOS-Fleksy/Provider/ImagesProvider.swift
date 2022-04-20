//
//  ImagesProvider.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 18/4/22.
//
import Foundation
import UIKit
import Combine

protocol ImagesProviderProtocol: BaseRepository {
    func loadImage(contextUrl:String, completionHadler: @escaping (Result<Data, APIError>) -> ())
}

class ImagesProvider: ImagesProviderProtocol {

    var baseURL: String
    var session: URLSession
    var cancellable: Set<AnyCancellable>

    init(baseURL: String, session: URLSession) {
        self.baseURL = baseURL
        self.session = session
        cancellable = []

    }

    func loadImage(contextUrl: String, completionHadler: @escaping (Result<Data, APIError>) -> ()) {

        let request: AnyPublisher<Data, Error> = execute(endpoint: API.getImage(contextUrl: contextUrl), queue: .main, retries: 1)
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

extension ImagesProvider {
    enum API {
        case getImage(contextUrl: String)
    }
}

extension ImagesProvider.API: APICall {

    var path: String {
        var pathAux = ""
        switch self {
        case .getImage(contextUrl: let context):
            pathAux = context
        }
        return pathAux
    }
    var method: String {
        switch self {
        case .getImage(contextUrl: _):
            return "GET"
        }
    }

    var queryParams: [URLQueryItem]? {
        return [URLQueryItem]()
    }

    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    func body() throws -> Data? {
        return nil
    }
}


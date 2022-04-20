//
//  BaseRepository.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 16/4/22.
//

import Foundation
import Combine

protocol BaseRepository {
    var session: URLSession { get }
    var baseURL: String { get }
    var cancellable: Set<AnyCancellable> { get }
}

extension BaseRepository {

    func execute<T>(endpoint: APICall, entityClass: T.Type, queue: DispatchQueue, retries: Int) -> AnyPublisher<T, Error> where T : Decodable {
        do {
            return session.dataTaskPublisher(for: try endpoint.urlRequest(baseURL: baseURL))
                .tryMap {
                    guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                        throw APIError.unexpectedResponse
                    }
                    return $0.data
                }
                .decode(type: T.self, decoder: JSONDecoder())
                .receive(on: queue)
                .retry(retries)
                .eraseToAnyPublisher()

        } catch let error {
            return Fail<T, Error>(error: error).eraseToAnyPublisher()
        }
    }

    func execute<Data>(endpoint: APICall, queue: DispatchQueue, retries: Int) -> AnyPublisher<Data, Error> {
        do {
            return session.dataTaskPublisher(for: try endpoint.urlRequest(baseURL: baseURL))
                .tryMap {
                    guard let response = $0.response as? HTTPURLResponse, response.statusCode == 200 else {
                        throw APIError.unexpectedResponse
                    }
                    return $0.data as! Data
                }
                .receive(on: queue)
                .retry(retries)
                .eraseToAnyPublisher()

        } catch let error {
            return Fail<Data, Error>(error: error).eraseToAnyPublisher()
        }
    }

}


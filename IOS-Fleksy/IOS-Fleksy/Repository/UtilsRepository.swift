//
//  UtilsRepository.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 16/4/22.
//

import Foundation

protocol APICall {
    var path: String { get }
    var method: String { get }
    var headers: [String: String]? { get }
    var queryParams: [URLQueryItem]? {get }
    func body() throws -> Data?
}

enum APIError: Error {
    case invalidURL
    case unexpectedResponse
    case imageProcessing([URLRequest])
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .unexpectedResponse: return "Unexpected response from the server"
        case .imageProcessing: return "Unable to load image"
        }
    }
}

extension APICall {

    func urlRequest(baseURL: String) throws -> URLRequest {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        var components =  URLComponents(
            url: url,
            resolvingAgainstBaseURL: false
        )
        components?.queryItems = queryParams
        guard let url = components?.url else {
            throw APIError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        return request
    }

}

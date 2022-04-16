//
//  MovieProviderResponse.swift
//  IOS-Fleksy
//
//  Created by Juanjo Núñez on 16/4/22.
//

import Foundation

// MARK: - MovieProviderResponse
struct MovieProviderResponse: Codable {
    let page, totalResults, totalPages: Int?
    let movies: [Movie]?
    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case movies = "results"
    }
}


// MARK: - Movie
struct Movie: Codable, Equatable, Identifiable {
    let posterPath: String?
    let id: Int?
    let name: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case voteAverage = "vote_average"
        case name

    }
}

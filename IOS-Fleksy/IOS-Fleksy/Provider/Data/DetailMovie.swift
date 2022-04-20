//
//  DetailMovie.swift
//  IOS-Fleksy
//
//  Created by Admin on 19/4/22.
//

import Foundation

import Foundation

// MARK: - DetailMovie
struct DetailMovie: Codable {
    let originalLanguage, originalName, overview, posterPath: String?
    let status, tagline, type: String?
    let voteAverage: Double?

    enum CodingKeys: String, CodingKey {
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case status, tagline, type
        case voteAverage = "vote_average"
    }
}

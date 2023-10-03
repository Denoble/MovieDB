//
//  Movie.swift
//  MovieDB
//
//  Created by Lawrence on 10/1/23.
//

import Foundation

// MARK: - Movie
struct Movie: Decodable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
}

// MARK: - Result
struct Result: Decodable {
    let adult: Bool
    let backdropPath: String?
    let genreIds: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
}

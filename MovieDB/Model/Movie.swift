//
//  Movie.swift
//  MovieDB
//
//  Created by Lawrence on 10/1/23.
//

import Foundation

// MARK: - MovieDBResults
struct MovieDBResults: Decodable {
    let page: Int
    let movies: [Movie]
    let totalPages, totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case movies = "results"
        case totalPages
        case totalResults
    }
}

// MARK: - Movie
struct Movie: Decodable, Identifiable {
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

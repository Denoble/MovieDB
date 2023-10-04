//
//  Movie.swift
//  MovieDB
//
//  Created by Lawrence on 10/1/23.
//

import Foundation




// MARK: - MovieDBSearchResult
struct MovieDBSearchResult: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int
}

// MARK: - Movie
struct Movie: Decodable {
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


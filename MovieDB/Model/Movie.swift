//
//  Movie.swift
//  MovieDB
//
//  Created by Lawrence on 10/1/23.
//

import Foundation
import CoreData

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

extension Movie {
    init(movieCoreData:CoreDataMovie){
        self.id = Int(movieCoreData.id)
        self.posterPath = movieCoreData.posterPath
        self.adult = movieCoreData.adult
        self.backdropPath = movieCoreData.backdropPath
        self.genreIds = movieCoreData.genreIds ?? [Int]()
        self.originalTitle = movieCoreData.originalTitle ?? " "
        self.originalLanguage = movieCoreData.originalLanguage ?? " "
        self.overview = movieCoreData.overview ?? " "
        self.popularity = movieCoreData.popularity
        self.releaseDate = movieCoreData.releaseDate ?? " "
        self.title = movieCoreData.title ?? " "
        self.video = movieCoreData.video
        self.voteAverage = movieCoreData.voteAverage
        self.voteCount = Int(movieCoreData.voteCount)
        
    }
}

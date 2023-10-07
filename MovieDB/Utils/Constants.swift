//
//  Constants.swift
//  MovieDB
//
//  Created by Lawrence on 10/2/23.
//

import Foundation

struct Constants {
    static let baseSearchUrl = "https://api.themoviedb.org/3/search/movie"
    static let basePosterUrl = "https://image.tmdb.org/t/p/original"
    static let baseTrendingUrl = "https://api.themoviedb.org/3/trending/movie/day"
    static let baseMovieCreditUrl = "https://api.themoviedb.org/3/movie/"
    static let baseCastProfileUrl = "https://api.themoviedb.org/3/person/"
    static let headers = ["accept": "application/json",
                          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5ZDliNzUzNmYwNTRhNGRhZTY5NTBkOGIwOWQ3OWNhOSIsInN1YiI6IjY1MTg4Mjk3OTY3Y2M3MzQyOGNhZTlhNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.BKKHnUe07Da9yYC4CorzM1TSydbobPuD4bsgZzGx-_0"]
    static let adult = URLQueryItem(name: "include_adult", value: "false")
    static let language = URLQueryItem(name: "language", value: "en-US")
}

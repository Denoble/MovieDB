//
//  TrendingResults.swift
//  MovieDB
//
//  Created by William Rozier on 10/4/23.
//


import Foundation
import SwiftUI

struct TrendingResults: Decodable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
}

struct TrendingItem: Identifiable, Decodable {
    let adult: Bool
    let id: Int
    let poster_path: String
    let title: String
    let vote_average: Double
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

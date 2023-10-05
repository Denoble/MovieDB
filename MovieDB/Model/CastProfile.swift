//
//  CastProfile.swift
//  MovieDB
//
//  Created by Amali Krigger on 10/4/23.
//

import Foundation

struct CastProfile: Decodable, Identifiable {

    let birthday: String?
    let id: Int
    let name: String
    let profilePath: String?

    var photoUrl: URL? {
        let baseURL = URL(string: "https://image.tmdb.org/t/p/w200")
        return baseURL?.appending(path: profilePath ?? "")
    }
}

//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Lawrence on 10/2/23.
//

import Foundation
import SwiftUI

@MainActor
class MovieDetailViewModel: ObservableObject {
    let imageCache: ImageCacheHelper
    let webService: MovieDBRepository
    init(webService: MovieDBRepository, imageCashe: ImageCacheHelper) {

    @Published var credits: MovieCredits?
    @Published var cast: [MovieCredits.Cast] = []
    @Published var castProfiles: [CastProfile] = []
    init(webService: MovieDBRepository, imageCache: ImageCacheHelper) {
        self.webService = webService
        self.imageCache = imageCache
    }
    
    func getPoster(posterPath: String) async throws -> UIImage? {
        if let cachedImage = imageCache.getImage(path: posterPath) {
            return cachedImage
        } else {
            let networkRequest = NetworkRequest(baseUrl: Constants.basePosterUrl, path: posterPath, params: [], type: .GET, headers: [:])
            do {
                let data = try await webService.fetchImageData(request: networkRequest)
                if let data = data {
                    guard let uiImage = UIImage(data: data) else { return nil }
                    imageCache.setImage(image: uiImage, path: posterPath)
                    return uiImage
                }
            } catch {
                throw error
            }
            return nil
        }
    }

    func movieCredits(for movieID: Int) async {
        let networkRequest = NetworkRequest(baseUrl: Constants.baseMovieCreditUrl, path: "\(movieID)/credits", params: [Constants.adult, Constants.language], type: .GET, headers: Constants.headers)
        do {
            let result = try await webService.fetchData(request: networkRequest, modelType: MovieCredits.self)
            self.credits = result
            guard let credits = self.credits else {
                return
            }
            self.cast = credits.cast.sorted(by: { $0.order < $1.order })
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }

    func loadCastProfiles() async {
        do {
            for member in cast {
                let networkRequest = NetworkRequest(baseUrl: Constants.baseCastProfileUrl, path: "\(member.id)", params: [Constants.adult, Constants.language], type: .GET, headers: Constants.headers)
                let result = try await webService.fetchData(request: networkRequest, modelType: CastProfile.self)
                guard let castProfile = result else {
                    return
                }
                castProfiles.append(castProfile)
            }
        } catch {
            print(error)
            print(error.localizedDescription)
        }
    }
}


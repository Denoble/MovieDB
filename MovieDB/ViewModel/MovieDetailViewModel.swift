//
//  MovieDetailViewModel.swift
//  MovieDB
//
//  Created by Lawrence on 10/2/23.
//

import Foundation
import SwiftUI

class MovieDetailViewModel: ObservableObject {
    let imageCache: ImageCacheHelper
    let webService: MovieDBRepository
    init(webService: MovieDBRepository, imageCashe: ImageCacheHelper) {
        self.webService = webService
        self.imageCache = imageCashe
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
}


//
//  Cache.swift
//  MovieDB
//
//  Created by Lawrence on 10/3/23.
//

import Foundation
import UIKit

protocol ImageCacheHelper {
    func getImage(path: String) -> UIImage?
    func setImage(image: UIImage?, path: String)
}

class ImageCache: ImageCacheHelper {
    private let cache = NSCache<NSString, UIImage>()

    func getImage(path: String) -> UIImage? {
        return cache.object(forKey: path as NSString)
    }

    func setImage(image: UIImage?, path: String) {
        if let image = image {
            cache.setObject(image, forKey: path as NSString)
        }
    }
}

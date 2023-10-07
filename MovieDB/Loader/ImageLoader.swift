//
//  ImageLoader.swift
//  MovieDB
//
//  Created by William Rozier on 10/4/23.
//
import Foundation

class ImageLoader: ObservableObject {
    
    @Published var downloadedData: Data?
    //custom controll to download image
    func downloadImage(url: String) {
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self.downloadedData = data
            }
            
        }.resume()
        
    }
    
}

//
//   MovieDBRepository.swift
//  MovieDB
//
//  Created by Uche Godfrey on 10/3/23.
//

import Foundation

protocol MovieDBRepository{
    func FetchMovieData<T: Decodable>(request: Requestable, modelType: T.Type) async throws -> T?
    func fetchImageData(request: Requestable) async throws -> Data?
    func getMovies() -> [Movie]?
    func saveMovie(movie:Movie)
    func deleteMovie(id:Int)
    
}
extension MovieDBRepository{
    func FetchMovieData<T: Decodable>(request: Requestable, modelType: T.Type) async throws -> T?{
        return T.self as? T
    }
    func fetchImageData(request: Requestable) async throws -> Data?{
        return Data()
    }
    func getMovies() -> [Movie]?{
        var movies:[Movie]? = nil
        return movies
    }
    func saveMovie(movie:Movie){
        print("Define this method")
    }
    func deleteMovie(id:Int){
        print("Define delete movie method")
    }
}

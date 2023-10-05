//
//  MovieDBRepository.swift
//  MovieDB
//
//  Created by Uche Godfrey on 10/2/23.
//

import Foundation
protocol MovieDBRepository{
    func FetchMovieData<T: Decodable>(request: Requestable, modelType: T.Type) async throws -> T?
    func fetchImageData(request: Requestable) async throws -> Data?
    func getMovies()async throws -> [Movie]
    func saveMovie(movie:Movie)async throws
    func deleteMovie(id:Int)async throws
    
}
extension MovieDBRepository{
    func FetchMovieData<T: Decodable>(request: Requestable, modelType: T.Type) async throws -> T?{
        return T.self as? T
    }
    func fetchImageData(request: Requestable) async throws -> Data?{
        return Data()
    }
    func getMovies()async throws -> [Movie]{
        return [Movie]()
    }
    func saveMovie(movie:Movie)async throws{
        print("Define this method")
    }
    func deleteMovie(id:Int)async throws {
        print("Define delete movie method")
    }
}


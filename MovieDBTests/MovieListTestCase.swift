//
//  MovieListTestCase.swift
//  MovieDBTests
//
//  Created by William Rozier on 10/8/23.
//

import XCTest
import Combine
@testable import MovieDB

class MockAPIImplement: APIImplement {
    
    var mockFetchDataResult: Result<MovieDBResults?, Error> = .success(nil)
    var mockFetchImageDataResult: Result<Data?, Error> = .success(nil)
    
    func fetchData<T>(request: MovieDB.Requestable, modelType: T.Type) async throws -> T? where T: Decodable {
        
        if let movieDBRequest = request as? MovieDB.Requestable {
            if movieDBRequest.path == "query" {
                
                let mockResponse = MovieDBResults(
                    page: 1,
                    movies: [/* Your mock Movie objects here */],
                    totalPages: 1,
                    totalResults: 1
                )
                return mockResponse as? T
            }
        }
        return nil
    }
    
    func fetchImageData(request: MovieDB.Requestable) async throws -> Data? {
       
        if let movieDBImageRequest = request as? MovieDB.Requestable {
            if movieDBImageRequest.path == "mockImagePath" {
                
                let mockImageData = Data("Mock image data".utf8)
                return mockImageData
            }
        }
        return nil
    }
    
    func fetchData<T>(request: NetworkRequest, modelType: T.Type) async throws -> T? where T: Decodable {
        switch mockFetchDataResult {
        case .success(let value):
            return value as? T
        case .failure(let error):
            throw error
        }
    }
}

class MovieListTestCase: XCTestCase {
    
  

}


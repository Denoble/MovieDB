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
    
    var viewModel: MovieListViewModel!
    var webServiceMock: MockAPIImplement!
    var cancellables: Set<AnyCancellable> = []
    // Define a mock MovieDBResults for testing
    let mockMovieDBResults = MovieDBResults(
        page: 1,
        movies: [
            //Movie(from: "Batman"),
            //Movie(from: "Starwars"),
            // Add more Movie objects here as needed
        ],
        totalPages: 1,
        totalResults: 2 // Adjust the totalResults count as needed
    )

    
           override func setUp() {
            super.setUp()
            webServiceMock = MockAPIImplement()
            viewModel = MovieListViewModel(webService: webServiceMock)
        }
            override func tearDown() {
            // Clean up any resources if needed
            viewModel = nil
            webServiceMock = nil
            super.tearDown()
        }
    func testGetMoviesSuccess() {
        // Arrange
        let query = "query"
        // Set up the web service mock to return a successful result
        webServiceMock.mockFetchDataResult = .success(mockMovieDBResults)
               
        
    }


}


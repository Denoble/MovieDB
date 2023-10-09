//
//  MovieListTestCase.swift
//  MovieDBTests
//
//  Created by William Rozier on 10/8/23.
//

import XCTest
import Combine
@testable import MovieDB

final class MovieListTestCase: XCTestCase {

    
    var viewModel: MovieListViewModel!
    var webServiceMock: MockAPIImplement!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        webServiceMock = MockAPIImplement()
        viewModel = MovieListViewModel(webService: webServiceMock)
    }

    override func tearDown() {
        viewModel = nil
        webServiceMock = nil
        cancellables.removeAll()
        super.tearDown()
    }

    @MainActor func testGetMovies() async {
        // Arrange
        let query = "query"
        let expectation = XCTestExpectation(description: "Loading movies successfully")
        let mockMovie = Movie(adult: false, backdropPath: nil, genreIds: [], id: 1, originalLanguage: "en", originalTitle: "Batman", overview: "Movie overview", popularity: 7.5, posterPath: "poster.jpg", releaseDate: "2022-01-01", title: "Batman", video: false, voteAverage: 7.0, voteCount: 100)
        let mockMovieDBResults = MovieDBResults(page: 1, movies: [mockMovie], totalPages: 1, totalResults: 1)
        webServiceMock.mockFetchDataResult = Result.success(mockMovieDBResults)

        // Act
        await viewModel.getMovies(query: query)
        
        // Assert
        viewModel.$viewState
            .sink { viewState in
                if viewState == .loaded {
                    XCTAssertEqual(self.viewModel.movies.count, 1)
                    XCTAssertEqual(self.viewModel.movies.first?.title, "Batman")
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetMoviesFailure() async {
        // Arrange
        let query = "query"
        let expectation = XCTestExpectation(description: "Failed to load movies")
        webServiceMock.mockFetchDataResult = Result.failure(NetworkError.invalidResponseError)

        // Act
        await viewModel.getMovies(query: query)
        
        // Assert
        viewModel.$viewState
            .sink { viewState in
                if viewState == .error {
                    XCTAssertTrue(self.viewModel.movies.isEmpty)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
}

// Define a mock implementation of your API service for testing
import Foundation

class MockAPIImplement: APIImplement {
    
    var mockFetchDataResult: Result<MovieDBResults?, Error> = .success(nil)
    var mockFetchImageDataResult: Result<Data?, Error> = .success(nil)

    func fetchData<T>(request: MovieDB.Requestable, modelType: T.Type) async throws -> T? where T: Decodable {
        // Customize this method to return mock data based on the request
        if let movieDBRequest = request as? MovieDB.Requestable {
            if movieDBRequest.path == "mockPath" {
                // Create a mock response object
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
        // Customize this method to return mock image data based on the request
        if let movieDBImageRequest = request as? MovieDB.Requestable {
            if movieDBImageRequest.path == "mockImagePath" {
                // For example, return a mock image data here
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



enum NetworkError: Error {
    case invalidResponseError
}

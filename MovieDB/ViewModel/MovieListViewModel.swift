//
//  MovieListViewModel.swift
//  MovieDB
//
//  Created by Lawrence on 10/2/23.
//

import Foundation

enum ViewState {
    case loading
    case loaded
    case error
}


class MovieListViewModel: ObservableObject {
    @Published var viewState = ViewState.loading
    
    var movies = [Movie]()
    var favoritesMovies = [Movie]()
    
    let webService: MovieDBRepository
    let coreData:MovieDBRepository
    init(webService: MovieDBRepository,coreData:MovieDBRepository) {
        self.webService = webService
        self.coreData = coreData
       // coreData.saveMovie(movie: movies,int:Index)
    }
    
    @MainActor
    func getMovies(query: String) async {
        self.viewState = .loading
        let networkRequest = NetworkRequest(baseUrl: Constants.baseSearchUrl, path: "", params: [Constants.adult, Constants.language, URLQueryItem(name: "query", value: query)], type: .GET, headers: Constants.headers)
        do {
            let result = try await webService.FetchMovieData(request: networkRequest, modelType: MovieDBResults.self)
            movies = result?.movies ?? []
            self.viewState = .loaded
        } catch {
            print(error)
            print(error.localizedDescription)
            self.viewState = .error
        }
    }
    @MainActor
    func fetchFavoriteMovies()async throws {
        self.viewState = .loading
        do{
            self.favoritesMovies = try await coreData.getMovies()
            self.viewState = .loaded
        }
        catch {
            print(error)
            print(error.localizedDescription)
            self.viewState = .error
        }
    }
    
    @MainActor
    func saveFavoriteMovies(movie:Movie)async throws {
        self.viewState = .loading
        do{
            try await coreData.saveMovie(movie: movie)
            self.viewState = .loaded
        }
        catch {
            print(error)
            print(error.localizedDescription)
            self.viewState = .error
        }
    }
}

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

@MainActor
class MovieListViewModel: ObservableObject {
    @Published var viewState = ViewState.loading
    @Published var movies = [Movie]()
    @Published var trendingMovies: [Movie] = []
    
    let webService: MovieDBRepository
    let coreData:MovieDBRepository
    init(webService: MovieDBRepository,coreData:MovieDBRepository) {
        self.webService = webService
        self.coreData = coreData
       // coreData.saveMovie(movie: movies,int:Index)
    }
    
    func getMovies(query: String) {
        Task {
            let networkRequest = NetworkRequest(baseUrl: Constants.baseSearchUrl, path: "", params: [Constants.adult, Constants.language, URLQueryItem(name: "query", value: query)], type: .GET, headers: Constants.headers)
            do {
                let result = try await webService.fetchData(request: networkRequest, modelType: MovieDBResults.self)
                movies = result?.movies ?? []
                self.viewState = .loaded
            } catch {
                print(error)
                print(error.localizedDescription)
                self.viewState = .error
            }
        }
    }

    func getTrendingMovies() {
        Task {
            let networkRequest = NetworkRequest(baseUrl: Constants.baseTrendingUrl, path: "", params: [Constants.adult, Constants.language], type: .GET, headers: Constants.headers)
            do {
                let result = try await webService.fetchData(request: networkRequest, modelType: TrendingResults.self)
                trendingMovies = result?.results ?? []
                self.viewState = .loaded
            } catch {
                print(error)
                print(error.localizedDescription)
                self.viewState = .error
            }
        }
    }
    @MainActor
    func deleteFavoriteMovie(id:Int) async throws {
        self.viewState = .loading
        do{
            try await coreData.deleteMovie(id: id)
            self.viewState = .loaded
        }catch{
            print(error)
            print(error.localizedDescription)
            self.viewState = .error
        }
    }
}

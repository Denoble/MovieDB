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
    
    let webService: APIImplement
    init(webService: APIImplement) {
        self.webService = webService
    }
    
    @MainActor
    func getMovies(query: String) async {
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
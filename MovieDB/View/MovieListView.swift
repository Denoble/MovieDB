//
//  MovieListView.swift
//  MovieDB
//
//  Created by William Rozier on 10/4/23.
//

import Foundation
import SwiftUI

import SwiftUI

struct MovieListView: View {
    @ObservedObject var viewModel: MovieListViewModel
    @State private var searchQuery = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Search Movies", text: $searchQuery)
                    .padding()
                
                Button("Search") {
                     viewModel.getMovies(query: searchQuery)
                }
                
                switch viewModel.viewState {
                case .loading:
                    ProgressView("Loading...")
                case .error:
                    Text("Error loading movies.")
                case .loaded:
                    List(viewModel.movies) { movie in
                        Text(movie.title)
                    }
                }
            }
            .navigationTitle("Movie List")
        }
    }
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView(viewModel: MovieListViewModel(webService: WebService()))
    }
}

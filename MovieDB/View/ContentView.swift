//
//  ContentView.swift
//  MovieDB
//
//  Created by Uche Godfrey on 9/29/23.
//

import SwiftUI

struct ContentView: View {
    // for testing purpose
    @StateObject var viewModel = MovieListViewModel(webService: WebService(), coreData: CoreDataManager())
    @StateObject var detailViewModel = MovieDetailViewModel(webService: WebService(), imageCache: ImageCache())
    @State var query = ""
    @State var uiImage = UIImage()
    var body: some View {
        Text("")
//        VStack {
//            TextField(text: $query) {
//                Text("Search")
//            }
//            Button {
//                Task {
//                    await viewModel.getMovies(query: query)
//                    do {
//                        uiImage = try await detailViewModel.getPoster(posterPath: viewModel.movies[0].posterPath ?? "") ?? UIImage()
//                    } catch {
//                        print(error)
//                    }
//                }
//            } label: {
//                Text("Tap to search")
//            }
//
//            Text("Movies: \(viewModel.movies.count)")
//            Image(uiImage: uiImage)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 300, height: 500)
//        }
//        .padding()
    }
}

//#Preview {
//    ContentView()
//}

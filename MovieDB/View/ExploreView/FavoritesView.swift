//
//  FavoritesView.swift
//  MovieDB
//
//  Created by Amali Krigger on 10/4/23.
//

import SwiftUI

struct FavoritesView: View {
  @StateObject var viewModel = MovieListViewModel(webService: WebService())
  @State var searchText = ""
  @State var imageWidth: CGFloat = UIScreen.main.bounds.width / 2
  @State var active = false
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading, spacing: 0) {
        Text("Favorites").font(.title).foregroundColor(.white)
          .fontWeight(.heavy).padding(.horizontal).padding(.bottom, 10)
        ScrollView {
          if viewModel.trendingMovies.isEmpty {
            Text("No Favorite Movies").padding().foregroundColor(.white)
          } else {
            ScrollView {
              VStack(alignment: .leading) {
                ForEach(viewModel.trendingMovies) { movie in
                  NavigationLink {
                    MovieDetailView(movie: movie)
                  } label: {
                    MovieCard(movie: movie)
                  }
                }
              }
              .padding(.horizontal)
            }
          }
        }
        .background(Color(red: 32 / 255, green: 33 / 255, blue: 35 / 255).ignoresSafeArea())
      }.background(Color(red: 32 / 255, green: 33 / 255, blue: 35 / 255))
        .onAppear {
          viewModel.getTrendingMovies()
        }
    }.background(Color(red: 32 / 255, green: 33 / 255, blue: 35 / 255))
  }
}

struct FavoritesView_Previews: PreviewProvider {
  static var previews: some View {
    FavoritesView()
  }
}


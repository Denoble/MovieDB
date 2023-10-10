//
//  ExploreMoviesView.swift
//  MovieDB
//
//  Created by Amali Krigger on 10/4/23.
//

import SwiftUI

struct ExploreMoviesView: View {
    @StateObject var viewModel = MovieListViewModel(webService: WebService())
    @State var searchText = ""
    @State var imageWidth: CGFloat = UIScreen.main.bounds.width / 2
    @State var active = false
    var body: some View {
        NavigationStack {
          VStack(alignment: .leading, spacing: 0) {
            Text("Search").font(.title).foregroundColor(.white)
              .fontWeight(.heavy).padding(.horizontal).padding(.bottom, 10)
            HStack {
              HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.gray)
                TextField(
                  "Search", text: $searchText,
                  onEditingChanged: { editing in
                    withAnimation {
                      active = editing
                    }
                  }
                )
                .onChange(of: searchText) { newValue in
                  if newValue.count > 2 {
                      viewModel.getMovies(query: newValue)
                  }
                }
              }
              .padding(10)
              .background(Color(white: 0.9))
              .cornerRadius(10)
              .padding(.vertical).padding(.leading, 15).padding(.trailing, active ? 0 : 15)
              Button("Cancel") {
                withAnimation {
                  active = false
                  searchText = ""
                }
              }
              .opacity(active ? 1 : 0)
              .frame(width: active ? 80 : 0, height: 10).padding(.trailing, active ? 10 : 0)
            }
            if searchText.isEmpty {
              HStack {
                Text("Trending")
                  .font(.title2)
                  .foregroundColor(.white)
                  .fontWeight(.heavy)
                Spacer()
              }.padding(.horizontal).padding(.top, 10).padding(.bottom, 20)
            } else {
              HStack {
                Text("Results")
                  .font(.title2)
                  .foregroundColor(.white)
                  .fontWeight(.heavy)
                Spacer()
              }.padding(.horizontal).padding(.top, 10).padding(.bottom, 25)
            }
            ScrollView {
              if searchText.isEmpty {
                  if viewModel.trendingMovies.isEmpty {
                  Text("No Results").padding().foregroundColor(.white)
                } else {
                  ScrollView {
                    VStack(alignment: .leading) {
                      ForEach(viewModel.trendingMovies) { movie in
                        NavigationLink {
                            MovieDetailView(movie: movie)
                        } label: {
                          MovieCard(movie: movie, viewModel: viewModel)
                        }
                      }
                    }
                    .padding(.horizontal)
                  }
                }
              } else {
                LazyVStack {
                  if viewModel.movies.isEmpty {
                    Text("No Results").padding().foregroundColor(.white)
                  } else {
                    ScrollView {
                      VStack(alignment: .leading) {
                          ForEach(viewModel.movies) { movie in
                          NavigationLink {
                            MovieDetailView(movie: movie)
                          } label: {
                            MovieCard(movie: movie, viewModel: viewModel)
                          }
                        }
                      }
                      .padding(.horizontal)
                    }
                  }
                }
              }
            }
            .background(Color(red: 32 / 255, green: 33 / 255, blue: 35 / 255).ignoresSafeArea())
          }.background(Color(red: 32 / 255, green: 33 / 255, blue: 35 / 255))
            .onAppear {
                viewModel.getTrendingMovies()
                try? viewModel.fetchFavoriteMovies()
            }
        }.background(Color(red: 32 / 255, green: 33 / 255, blue: 35 / 255))
    }
}

struct ExploreMoviesView_Previews: PreviewProvider {
  static var previews: some View {
      ExploreMoviesView()
  }
}


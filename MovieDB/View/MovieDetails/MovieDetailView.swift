//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by Amali Krigger on 10/4/23.
//

import Foundation
import SwiftUI

struct MovieDetailView: View {

  @Environment(\.dismiss) var dismiss
  @StateObject var model = MovieDetailViewModel(webService: WebService(), imageCache: ImageCache())
  let movie: Movie
  let headerHeight: CGFloat = 400

  var body: some View {
    ZStack {
      Color(red: 32 / 255, green: 33 / 255, blue: 35 / 255).ignoresSafeArea()
      VStack {
        GeometryReader { geo in
          VStack {
            AsyncImage(url: movie.backdropURL) { image in
              image
                .resizable()
                .scaledToFill()
                .frame(maxWidth: geo.size.width, maxHeight: headerHeight)
                .clipShape(RoundedRectangle(cornerRadius: 15))
            } placeholder: {
              ProgressView()
            }.overlay(.black.opacity(0.4))
          }
        }
        ScrollView {
          VStack(spacing: 12) {
            HStack {
              Text(movie.title)
                .font(.title)
                .fontWeight(.heavy)
                .foregroundStyle(.white)
              Spacer()
              // ratings here
            }

            HStack {
              // genre tags

              // running time
            }

            HStack {
              Text("About film")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.white)
              Spacer()
              // see all button
            }

            Text(movie.overview)
              .foregroundStyle(.gray)
            HStack {
              Text("Cast & Crew")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(.white)
              Spacer()
              // see all button
            }

            ScrollView(.horizontal, showsIndicators: false) {
              LazyHStack {
                ForEach(model.castProfiles) { cast in
                  CastView(cast: cast)
                }
              }
            }
          }
          .padding(.horizontal).padding(.bottom, 30).padding(.top, 15)
        }
      }
    }
    .edgesIgnoringSafeArea(.top)
    .overlay(alignment: .topLeading) {
      Button {
        dismiss()
      } label: {
        Image(systemName: "chevron.left")
          .imageScale(.large)
          .fontWeight(.bold)
      }
      .padding(.leading)
    }
    .toolbar(.hidden, for: .navigationBar)
    .task {
        await model.movieCredits(for: movie.id)
        await model.loadCastProfiles()
    }
  }

}

//struct MovieDetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    MovieDetailView(movie: .preview)
//  }
//}


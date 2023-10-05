//
//  MovieCard.swift
//  MovieDB
//
//  Created by Amali Krigger on 10/4/23.
//

import SwiftUI

struct MovieCard: View {
  @State var movie: Movie
  @State var imageWidth: CGFloat = UIScreen.main.bounds.width / 2

  var body: some View {
    HStack {
      ZStack {
          AsyncImage(url: movie.backdropURL) { image in
          image
            .resizable()
            .scaledToFill()
        } placeholder: {
          Rectangle().fill(Color(red: 61 / 255, green: 61 / 255, blue: 88 / 255))
        }
      }
      .cornerRadius(10)
      .padding(.vertical).padding(.trailing, 15)
    }.frame(width: imageWidth, height: 115)
    VStack(alignment: .leading) {
      HStack {
        Text(movie.title)
          .foregroundColor(.white)
          .fontWeight(.heavy)
          .font(.subheadline)
          .lineLimit(1)
          .multilineTextAlignment(.leading)
      }
      Spacer()
      HStack {
        Text(movie.overview)
          .foregroundColor(.white)
          .font(.footnote)
          .lineLimit(2)
          .truncationMode(.tail)
          .multilineTextAlignment(.leading)
      }
      Spacer()
      HStack {
        Image(systemName: "heart.fill")
              .foregroundColor(.red).onTapGesture {
                  print("Add favorite movie")
              }
        HStack {
          Image(systemName: "hand.thumbsup.fill").resizable().frame(
            width: 15, height: 15)
            Text(String(format: "%.1f", movie.voteAverage))
        }
        .foregroundColor(.yellow)
        .fontWeight(.heavy)
      }
    }
    .padding(.vertical)
    .padding(.trailing, 10)
  }
}

//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Uche Godfrey on 9/29/23.
//

import SwiftUI

@main
struct MovieDBApp: App {
    var body: some Scene {
        WindowGroup {
              TabView {
                  ExploreMoviesView()
                      .tabItem {
                          Image(systemName: "popcorn")
                      }.toolbarBackground(Color(red: 32 / 255, green: 33 / 255, blue: 35 / 255), for: .tabBar)
                  FavoritesView()
                      .tabItem {
                          Image(systemName: "heart.fill")
                      }.toolbarBackground(Color(red: 32 / 255, green: 33 / 255, blue: 35 / 255), for: .tabBar)
              }.accentColor(.yellow)
          }
    }
}

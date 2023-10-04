//
//  MovieDetailView.swift
//  MovieDB
//
//  Created by William Rozier on 10/4/23.
//

import SwiftUI
import UIKit

struct MovieDetailView: View {
    @ObservedObject var viewModel: MovieDetailViewModel

    var body: some View {
        // Your content for displaying movie details
        Text("Movie Detail View")
            .navigationTitle("Movie Detail")
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(viewModel: MovieDetailViewModel(
            webService: WebService(),
            imageCashe: ImageCache()
        ))
    }
}

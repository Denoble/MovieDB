//
//  MovieModelBase.swift
//  MovieDB
//
//  Created by William Rozier on 10/4/23.
//

import SwiftUI

enum LoadingState {
    case loading, success, failed, none
}

class ViewModelBase: ObservableObject {
    @Published var loadingState: LoadingState = .none
}

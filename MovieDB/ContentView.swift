//
//  ContentView.swift
//  MovieDB
//
//  Created by Uche Godfrey on 9/29/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(alignment: .leading, content: {
            Text("Hello SwiftUI")
        }
        ).frame(width: .infinity, height: .infinity)
            .background(Color.gray)
    }
}

#Preview {
    ContentView()
}

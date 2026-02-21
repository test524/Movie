//
//  MovieApp.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 15/02/26.
//

import SwiftUI

@main
struct MovieApp: App {
    @State private var router = AppRouter()
    var body: some Scene {
        WindowGroup {
            MoviesTabView()
                .environment(router)
        }
    }
}


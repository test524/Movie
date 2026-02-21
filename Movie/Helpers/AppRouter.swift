//
//  AppRouter.swift
//  Movie
//
//  Created by Pavan Kumar Reddy on 17/02/26.
//
import SwiftUI
import Foundation
import Observation

enum NowRoute: Hashable {
    case movieDetails(id: Int)
}

enum PopularRoute: Hashable {
    case movieDetails(id: Int)
}

enum TopRatedRoute: Hashable {
    case movieDetails(id: Int)
}

enum UpComingRoute: Hashable {
    case movieDetails(id: Int)
}


@Observable
final class AppRouter {

    var nowPath = NavigationPath()
    var popularPath = NavigationPath()
    var topPath = NavigationPath()
    var upcomingPath = NavigationPath()

    // MARK: - Navigation helpers

    // Generic Push
    func push<T: Hashable>(_ route: T, to path: inout NavigationPath) {
        path.append(route)
    }
    
    // Generic Pop (Go Back)
    func pop(from path: inout NavigationPath) {
        if !path.isEmpty {
            path.removeLast()
        }
    }

    func popToRoot() {
       // path.removeAll()
    }

    func goToDashboard(userID: String) {
        //path.removeAll()
        //root = .dashboard(userID: userID)
    }

    func logout() {
        //path.removeAll()
        //root = .login
    }
}

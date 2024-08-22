//
//  Router.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 19/08/24.
//

import SwiftUI

class Router: ObservableObject {
    // Contains the possible destinations in our Router
    enum Route: Hashable {
        case LoginView
        case HomeView
        case AddEmergencyContact
        case CountdownView
        case StatusTrackView
    }

    // Used to programatically control our navigation stack
    @Published var path: NavigationPath = .init()

//     Builds the views
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .LoginView:
            LoginView()
        case .HomeView:
            HomeView()
        case .AddEmergencyContact:
            AddEmergencyContactView()
        case .CountdownView:
            CountdownView()
        case .StatusTrackView:
            StatusTrackView()
        }
    
    }

    // Used by views to navigate to another view
    func navigateTo(_ appRoute: Route) {
        path.append(appRoute)
    }

    // Used to go back to the previous screen
    func navigateBack() {
        path.removeLast()
    }

    // Pop to the root screen in our hierarchy
    func popToRoot() {
        path.removeLast(path.count)
    }
}

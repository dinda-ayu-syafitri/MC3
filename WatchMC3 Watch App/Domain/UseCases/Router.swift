//
//  Router.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 15/08/24.
//

import Foundation
import SwiftUI
import Combine

enum Route {
    case home
    case countdown
}

class Router: ObservableObject {
    @Published var currentRoute: Route = .home
    
    func navigate(to route: Route) {
        currentRoute = route
    }
    
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .home:
            HomeView()
        case .countdown:
            CountdownView(heartRateViewModel: HeartRateViewModel())
        }
    }
}



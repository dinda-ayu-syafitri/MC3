//
//  RouterWatch.swift
//  WatchMC3 Watch App
//
//  Created by Dinda Ayu Syafitri on 20/08/24.
//

import SwiftUI

class RouterWatch: ObservableObject {
    // Contains the possible destinations in our Router
    enum Route: Hashable {
        case homeView, settingView, countdownView, jumpView, deactivateView
    }
    
    // Used to programatically control our navigation stack
    @Published var path: NavigationPath = .init()
    
    //     Builds the views
    @ViewBuilder func view(for route: Route) -> some View {
        switch route {
        case .homeView:
            Home()
        case .countdownView:
            CountdownView()
        case .jumpView:
            HBJumpView()
        case .deactivateView:
            DeactivateView()
        case .settingView:
            SettingsView(homeVM: HomeViewModel())
            
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

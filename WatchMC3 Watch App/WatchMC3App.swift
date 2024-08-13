//
//  WatchMC3App.swift
//  WatchMC3 Watch App
//
//  Created by Dinda Ayu Syafitri on 12/08/24.
//

import SwiftUI

@main
struct WatchMC3_Watch_AppApp: App {
    
    @StateObject var healthKitManager = HealthKitManager()
    
    var body: some Scene {
        WindowGroup {
            if healthKitManager.isAuthorized {
                HomeView()
            } else {
                Text("Requesting health data access...")
                    .onAppear {
                        healthKitManager.requestAuthorization()
                    }
            }
        }
    }
}

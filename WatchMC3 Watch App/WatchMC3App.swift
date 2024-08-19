//
//  WatchMC3App.swift
//  WatchMC3 Watch App
//
//  Created by Dinda Ayu Syafitri on 12/08/24.
//

import SwiftUI
import UserNotifications

@main
struct WatchMC3_Watch_AppApp: App {
    
    @StateObject var healthKitManager = HealthKitManager()
    private let notificationDelegate = NotificationDelegate()
    @StateObject var watchConnector = WatchToiOSConnector()
    
    init() {
        // Set the UNUserNotificationCenter's delegate to our custom delegate
        UNUserNotificationCenter.current().delegate = notificationDelegate
        
        // Register notification categories here if needed
        NotificationManager.shared.registerActionsWithCategories()
        
        // Request notification permissions
        NotificationManager.shared.requestAuthorization { granted in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            if healthKitManager.isAuthorized {
                AllViews()
            } else {
                Text("Requesting health data access...")
                    .onAppear {
                        healthKitManager.requestAuthorization()
                    }
            }
        }
    }
}

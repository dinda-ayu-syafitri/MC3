//
//  MC3App.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 09/08/24.
//

import SwiftUI

@main
struct MC3App: App {
    
    private let notificationDelegate = NotificationDelegate()

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
            ContentView()
        }
    }
}

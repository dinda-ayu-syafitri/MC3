//
//  NotificationManager.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 13/08/24.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {
        registerActionsWithCategories()
    }
    
    //request permission
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            }
            completion(granted)
        }
    }
    
    //register actions with categories
    func registerActionsWithCategories() {
        
        let okayAction = UNNotificationAction(identifier: "Okay_Action",
                                              title: "I'm okay",
                                              options: [])
        
        let sosCategory = UNNotificationCategory(identifier: "SOS_Category",
                                                 actions: [okayAction],
                                                 intentIdentifiers: [],
                                                 options: [])
        
        //register category with the shared notification center
        UNUserNotificationCenter.current().setNotificationCategories([sosCategory])
    }
    
    
    //schedule a notification
    func scheduleNotification(title: String, body: String, category: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.categoryIdentifier = category
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: UNTimeIntervalNotificationTrigger(timeInterval: 0.001, repeats: false))
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to add notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled successfully.")
            }
        }
    }
}


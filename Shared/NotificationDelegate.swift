//
//  NotificationDelegate.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 13/08/24.
//

import Foundation
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    //handle notification actions
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        if response.actionIdentifier == "Okay_Action" {
            print("glad you're okay, we will do another check-in regularly")

            //call the completion handler whendone
            completionHandler()
        }
    }
    
    //handle notification delivery while app is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}

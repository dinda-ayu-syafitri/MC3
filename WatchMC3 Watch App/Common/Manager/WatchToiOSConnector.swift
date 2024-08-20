//
//  WatchToiOSConnector.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 13/08/24.
//

import Foundation
import WatchConnectivity

class WatchToiOSConnector: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession
    static let shared = WatchToiOSConnector()
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
    func sendTriggerToiOS(notificationType: NotificationTypeEnum) {
        print("Send trigger to ios from apple watch")
        
        if session.isReachable {
            let message = ["action" : notificationType.toString]
            session.sendMessage(message, replyHandler: nil) { error in
                print("Error sending message: \(error.localizedDescription)")
            }
            
        } else {
            // fallback to using updateApplicationContext
            
//            NotificationManager.shared.scheduleNotification(
//                title: "Abnormal Heart Rate",
//                body: "are you okay?",
//                category: NotificationTypeEnum.ABNORMALHEARTRATE.toString)
            
            let context = ["action": "sosAlert"]
            do {
                try session.updateApplicationContext(context)
                print("Application context updated successfully")
            } catch {
                print("Failed to update application context: \(error.localizedDescription)")
            }
            
            //DEBUG: print
            print("Session is not reachable; context sent instead")
        }
        
    }
}

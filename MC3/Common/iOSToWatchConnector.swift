//
//  WatchConnector.swift
//  MC3
//
//  Created by Michelle Chau on 13/08/24.
//

import Foundation
import WatchConnectivity

class iOSToWatchConnector: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession
    @Published var messageText = ""
    
    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        handleReceivedMessage(message)
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        handleReceivedMessage(applicationContext)
    }
    
    private func handleReceivedMessage(_ message: [String : Any]) {
        //DEBUG
        print(message)
        
        if let action = message["action"] as? String, action == "sosAlert" {
            // Trigger SOS alert here
            print("SOS alert triggered from Apple Watch!")
            // Notify the user or trigger a local notification
            NotificationManager.shared.scheduleNotification(
                title: "SOS Alert Triggered",
                body: "The Apple Watch has sent an SOS alert.",
                category: "SOS_Category"
            )
        } else {
            print("Unknown action received: \(message)")
        }
    }
    
    //    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
    //        print(message)
    //        print(message["action"] as? String ?? "Unknown")
    //        self.messageText = message["action"] as? String ?? "Unknown"
    //
    //        //DEBUG: local notif to notify message has been received
    //        NotificationManager.shared.scheduleNotification(
    //            title: "trigger send alert", body: "None", category: "SOS_Category")
    //
    //        DispatchQueue.main.async {
    //            self.messageText = message["action"] as? String ?? "Unknown"
    //        }
    //    }
    
    
}

//        if let action = message["action"] as? String, action == "sosAlert" {
//                // Trigger SOS alert here
//                print("SOS alert triggered from Apple Watch!")
//                // Add your SOS alert logic here
//            } else {
//                print("Unknown action received: \(message)")
//            }

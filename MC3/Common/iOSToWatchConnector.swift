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
        print("foreground")
        handleReceivedMessage(message)
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("background")
        handleReceivedMessage(applicationContext)
    }
    
    private func handleReceivedMessage(_ message: [String : Any]) {
        //DEBUG: print message
        print(message)
        print("SOS alert triggered from Apple Watch!")
        if let action = message["action"] as? String, action == "sosAlert" {
            //trigger SOS alert here
            print("SOS alert triggered from Apple Watch!")
            
            //notify the user or trigger a local notification
            NotificationManager.shared.scheduleNotification(
                title: "SOS Alert Triggered",
                body: "The Apple Watch has sent an SOS alert.",
                category: "SOS_Category"
            )
            
            //DEBUG: update content view
            DispatchQueue.main.async {
                self.messageText = message["action"] as? String ?? "Unknown"
            }
        } else {
            print("Unknown action received: \(message)")
        }
    }
}



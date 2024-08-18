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
        
        let message = ["action" : notificationType.toString]
        session.sendMessage(message, replyHandler: nil) { error in
            print("Error sending message: \(error.localizedDescription)")
        }
    }
}

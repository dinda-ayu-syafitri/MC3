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
    
    func sendTriggerToiOS() {
        //DEBUG: print
        print("Attempting to send message to iPhone")
        if session.isReachable {
            print("reachable")
            
            let message = ["action": "sosAlert"] // the message dictionary
            session.sendMessage(message, replyHandler: nil) { error in
                print("Error sending message: \(error.localizedDescription)")
            }
            
            //DEBUG: print
            print("Session is reachable and message sent")
            
        } else {
            print("not reachable")
            // fallback to using updateApplicationContext
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

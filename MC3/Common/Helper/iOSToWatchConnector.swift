//
//  WatchConnector.swift
//  MC3
//
//  Created by Michelle Chau on 13/08/24.
//

import Foundation
import SwiftUI
import WatchConnectivity

class iOSToWatchConnector: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession
    var messageViewModel = DependencyInjection.shared.MessageNotifViewModel()
    @Published var messageText = ""

    var emergencyContactSaved: [EmergencyContacts]? = []
    var userTracked = false

    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}

    func sessionDidBecomeInactive(_ session: WCSession) {}

    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }

    func session(_ session: WCSession, didReceiveMessage message: [String: Any]) {
        print("foreground")
        handleReceivedMessage(message)
    }

    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String: Any]) {
        print("background")
        handleReceivedMessage(applicationContext)
    }

    private func handleReceivedMessage(_ message: [String: Any]) {
        if let action = message["action"] as? String {
            if action == NotificationTypeEnum.ABNORMALHEARTRATE.toString {
                NotificationManager.shared.scheduleNotification(
                    title: "Abnormal heart rate detected",
                    body: "Are you okay?",
                    category: action
                )
            } else if action == NotificationTypeEnum.SOSALERT.toString {
                NotificationManager.shared.scheduleNotification(
                    title: "SOS has been sent",
                    body: "We already sent you live location",
                    category: action
                )
                messageViewModel.startSendingNotifications(
                    emergencyContactSaved: emergencyContactSaved ?? []
                )

//                print("Starting notifications, userTrackedMessage: \(messageViewModel.userTrackedMessage)")
//
//                // Check if user is already tracked
//                if messageViewModel.userTrackedMessage != "userTracked" {
//                    // Start sending notifications
//                    messageViewModel.startSendingNotifications(
//                        emergencyContactSaved: emergencyContactSaved,
//                        userTracked: &userTracked
//                    )
//                    print("Starting notifications, userTrackedMessage: \(messageViewModel.userTrackedMessage)")
//                } else {
//                    // Stop sending notifications if already tracked
//                    messageViewModel.stopSendingNotifications()
//                    print("Stopping notifications, userTrackedMessage: \(messageViewModel.userTrackedMessage)")
//                }
            }
        } else {
            print("Unknown action received: \(message)")
        }

        DispatchQueue.main.async {
            self.messageText = message["action"] as? String ?? "no data"
        }
    }
}

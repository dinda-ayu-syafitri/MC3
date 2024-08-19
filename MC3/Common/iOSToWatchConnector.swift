//
//  WatchConnector.swift
//  MC3
//
//  Created by Michelle Chau on 13/08/24.
//

import Foundation
import SwiftData
import SwiftUI
import WatchConnectivity

class iOSToWatchConnector: NSObject, WCSessionDelegate, ObservableObject {
    var session: WCSession
    var messageViewModel = MessageNotificationViewModel()
    @Published var messageText = ""

    @Query public var emergencyContactSaved: [EmergencyContacts]

    init(session: WCSession = .default) {
        self.session = session
        super.init()
        session.delegate = self
        session.activate()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {}

    func sessionDidBecomeInactive(_ session: WCSession) {}

    func sessionDidDeactivate(_ session: WCSession) {}

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

                if let firstContact = emergencyContactSaved.first {
                    for contact in firstContact.emergencyContacts {
                        let fcmToken = TokenManager.shared.fcmToken ?? ""

                        messageViewModel.sendPushNotification(
                            token: contact.fcm ?? "",
                            title: "\(contact.fullName) needs your help!",
                            body: "\(contact.fullName) sent you an SOS message. Reach out to her immediately!",
                            locationLink: "testing",
                            senderFCM: fcmToken
                        )
                    }
                }
            }
        } else {
            print("Unknown action received: \(message)")
        }

        DispatchQueue.main.async {
            self.messageText = message["action"] as? String ?? "no data"
        }
    }
}

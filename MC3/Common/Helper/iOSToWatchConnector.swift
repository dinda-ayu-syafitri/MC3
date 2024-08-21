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
    var messageViewModel = MessageNotificationViewModel()
    @Published var messageText = ""

    var emergencyContactSaved: [EmergencyContacts]? = []
    var userTracked = false
    var notificationTimer: Timer?

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
        print("foreground emergency contact: \(emergencyContactSaved)")
        print("foreground emergency contact: \(emergencyContactSaved?.first)")
        print("foreground emergency contact: \(emergencyContactSaved?.first?.emergencyContacts.first?.fullName)")
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
                if let emergencyContacts = emergencyContactSaved, !emergencyContacts.isEmpty {
                    for contact in emergencyContacts.first?.emergencyContacts ?? [] {
                        let fcmToken = TokenManager.shared.fcmToken ?? ""

                        messageViewModel.startSendingNotifications(emergencyContactSaved: emergencyContactSaved, userTracked: &userTracked)
//                        messageViewModel.sendPushNotification(
//                            token: contact.fcm ?? "",
//                            title: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") needs your help!",
//                            body: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") sent you an SOS message. Reach out to her immediately!",
//                            locationLink: "\(UserDefaults.standard.string(forKey: "idFirebase") ?? "No ID Firebase")",
//                            senderFCM: fcmToken
//                        )
                    }

                    print("Emergency contact is not empty")
                } else {
                    print("Test")
                }

                messageViewModel.startSendingNotifications(
                    emergencyContactSaved: emergencyContactSaved,
                    userTracked: &userTracked
                )
            } else if action == "userTracked" {
                userTracked = true
                notificationTimer?.invalidate()
                notificationTimer = nil
            }
        } else {
            print("Unknown action received: \(message)")
        }

        DispatchQueue.main.async {
            self.messageText = message["action"] as? String ?? "no data"
        }
    }
//    private func handleReceivedMessage(_ message: [String: Any]) {
//        if let action = message["action"] as? String {
//            if action == NotificationTypeEnum.ABNORMALHEARTRATE.toString {
//                print("abnormal : \(action)")
//                NotificationManager.shared.scheduleNotification(
//                    title: "Abnormal heart rate detected",
//                    body: "Are you okay?",
//                    category: action
//                )
//            } else if action == NotificationTypeEnum.SOSALERT.toString {
//                print("sos : \(action)")
//                NotificationManager.shared.scheduleNotification(
//                    title: "SOS has been sent",
//                    body: "We already sent you live location",
//                    category: action
//                )
//
//                if let emergencyContacts = emergencyContactSaved, !emergencyContacts.isEmpty {
//                    for contact in emergencyContacts.first?.emergencyContacts ?? [] {
//                        let fcmToken = TokenManager.shared.fcmToken ?? ""
//
//                        messageViewModel.startSendingNotifications(emergencyContactSaved: emergencyContactSaved, userTracked: &userTracked, notificationTimer: &notificationTimer)
//    //                        messageViewModel.sendPushNotification(
//    //                            token: contact.fcm ?? "",
//    //                            title: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") needs your help!",
//    //                            body: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") sent you an SOS message. Reach out to her immediately!",
//    //                            locationLink: "\(UserDefaults.standard.string(forKey: "idFirebase") ?? "No ID Firebase")",
//    //                            senderFCM: fcmToken
//    //                        )
//                    }
//
//                    print("Emergency contact is not empty")
//                } else {
//                    print("Test")
//                }
//            }
//        } else {
//            print("Unknown action received: \(message)")
//        }
//
//        DispatchQueue.main.async {
//            self.messageText = message["action"] as? String ?? "no data"
//        }
//    }
}

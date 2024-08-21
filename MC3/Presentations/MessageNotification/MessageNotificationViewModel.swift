//
//  MessageNotificationViewModel.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 15/08/24.
//

import Foundation

class MessageNotificationViewModel: ObservableObject {
    @Published var fcmToken: String = ""
    var dispatchTimer: DispatchSourceTimer?

    func sendPushNotification(token: String, title: String, body: String, locationLink: String, senderFCM: String) {
        let url = URL(string: "https://mc-3-server.vercel.app/send")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let json: [String: Any] = ["token": token, "title": title, "body": body, "locationLink": locationLink, "senderFCM": senderFCM]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
            }
        }

        task.resume()
    }

    func startSendingNotifications(emergencyContactSaved: [EmergencyContacts]?, userTracked: inout Bool) {
        guard !userTracked else {
            print("User is already tracked, not starting notifications.")
            return
        }

        guard let emergencyContacts = emergencyContactSaved, !emergencyContacts.isEmpty else {
            print("No emergency contacts available, not starting notifications.")
            return
        }

        // Cancel any existing timer
        dispatchTimer?.cancel()

        dispatchTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        dispatchTimer?.schedule(deadline: .now(), repeating: .seconds(1))

        dispatchTimer?.setEventHandler { [weak self] in
            guard let self = self else {
                print("Self is nil, stopping the timer.")
                return
            }

            print("Timer fired, sending notifications...")

            for contact in emergencyContacts.first?.emergencyContacts ?? [] {
                let fcmToken = TokenManager.shared.fcmToken ?? ""
                print("Sending notification to contact with FCM token: \(contact.fcm ?? "nil")")

                self.sendPushNotification(
                    token: contact.fcm ?? "",
                    title: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") needs your help!",
                    body: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") sent you an SOS message. Reach out to her immediately!",
                    locationLink: "\(UserDefaults.standard.string(forKey: "idFirebase") ?? "No ID Firebase")",
                    senderFCM: fcmToken
                )
            }

            print("Repeated notification sent")
        }
        dispatchTimer?.resume()
        print("Notification timer started.")
    }
}

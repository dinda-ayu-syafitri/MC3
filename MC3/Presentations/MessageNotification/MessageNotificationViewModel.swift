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

    private var userDefaultUseCase: UserDefaultUseCaseProtocol

    init(userDefaultUseCase: UserDefaultUseCaseProtocol) {
        self.userDefaultUseCase = userDefaultUseCase
    }

    func sendPushNotification(token: String, title: String, body: String, locationLink: String, senderFCM: String, customMessage: String) {
        let url = URL(string: "https://mc-3-server.vercel.app/send")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let json: [String: Any] = ["token": token, "title": title, "body": body, "locationLink": locationLink, "senderFCM": senderFCM, "customMessage": customMessage]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)

        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("fcm : \(token) Response: \(responseString)")
            }
        }

        task.resume()
    }

    func saveTrackStatus(status: String, locationID: String) {
        userDefaultUseCase.saveData(data: status, key: .trackedStatus)
        userDefaultUseCase.saveData(data: locationID, key: .roomLiveLocation)
    }

    func startSendingNotifications(emergencyContactSaved: [EmergencyContacts]) {
//        print("guyg")
//        for contact in emergencyContactSaved?.first?.emergencyContacts ?? [] {
//            print("Nama: \(contact.fullName) | fcm: \(String(describing: contact.fcm))")
//        }
//
        saveTrackStatus(status: "", locationID: "")
//
//        guard let emergencyContacts = emergencyContactSaved, !emergencyContacts.isEmpty else {
//            print("No emergency contacts available, not starting notifications.")
//            return
//        }

        // Cancel any existing timer
        dispatchTimer?.cancel()
        dispatchTimer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
        dispatchTimer?.schedule(deadline: .now(), repeating: .seconds(1))

        dispatchTimer?.setEventHandler { [weak self] in
            guard let self = self else { return }

            print("\(UserDefaults.standard.string(forKey: "trackedStatus") ?? "No trackedStatus")")
            // Immediate check before sending another notification
            if UserDefaults.standard.string(forKey: "trackedStatus") == "userTracked" {
                self.stopSendingNotifications()
                dispatchTimer?.cancel()
                dispatchTimer = nil
                print("Stop Notification Called Again")
                return
            } else {
                DispatchQueue.main.async {
                    if !emergencyContactSaved.isEmpty {
                        for contact in emergencyContactSaved {
                            for data in contact.emergencyContacts {
                                let fcmToken = TokenManager.shared.fcmToken ?? ""
                                self.sendPushNotification(
                                    token: data.fcm ?? "",
                                    title: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") needs your help!",
                                    body: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") sent you an SOS message. Reach out to her immediately!",
                                    locationLink: "\(UserDefaults.standard.string(forKey: "idFirebase") ?? "No ID Firebase")",
                                    senderFCM: fcmToken,
                                    customMessage: ""
                                )
                            }
                        }
                    } else {
                        print("Emergency Contact Empty")
                    }

//                    if let emergencyContacts = emergencyContactSaved, !emergencyContacts.isEmpty {
//                        for contact in emergencyContacts {
//                            if let c = contact, c
//                        }
                    ////                        for contacts in emergencyContacts {
                    ////                            if let contact = contacts {
                    ////                                for c in contact {
                    ////                                    let fcmToken = TokenManager.shared.fcmToken ?? ""
                    ////                                    self.sendPushNotification(
                    ////                                        token: contact.fcm ?? "",
                    ////                                        title: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") needs your help!",
                    ////                                        body: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") sent you an SOS message. Reach out to her immediately!",
                    ////                                        locationLink: "\(UserDefaults.standard.string(forKey: "idFirebase") ?? "No ID Firebase")",
                    ////                                        senderFCM: fcmToken,
                    ////                                        customMessage: ""
                    ////                                    )
                    ////                                }
                    ////                            }
                    ////                        }
//                    } else {
//                        print("Emergency Contact Empty")
//                    }
//
//                    if !emergencyContactSaved.isEmpty {
//                        for contact in emergencyContactSaved {
//                            for data in contact {
//                                let fcmToken = TokenManager.shared.fcmToken ?? ""
//                                self.sendPushNotification(
//                                    token: data.fcm ?? "",
//                                    title: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") needs your help!",
//                                    body: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") sent you an SOS message. Reach out to her immediately!",
//                                    locationLink: "\(UserDefaults.standard.string(forKey: "idFirebase") ?? "No ID Firebase")",
//                                    senderFCM: fcmToken,
//                                    customMessage: ""
//                                )
//                            }
//                        }
//                    } else {
//                        print("Emergency Contact Empty")
//                    }

//                    for contact in emergencyContacts.first?.emergencyContacts ?? [] {
//                        let fcmToken = TokenManager.shared.fcmToken ?? ""
//                        self.sendPushNotification(
//                            token: contact.fcm ?? "",
//                            title: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") needs your help!",
//                            body: "\(UserDefaults.standard.string(forKey: "fullName") ?? "Name Not Found") sent you an SOS message. Reach out to her immediately!",
//                            locationLink: "\(UserDefaults.standard.string(forKey: "idFirebase") ?? "No ID Firebase")",
//                            senderFCM: fcmToken,
//                            customMessage: ""
//                        )
//                    }
                }
            }
        }
        dispatchTimer?.resume()
    }

    func stopSendingNotifications() {
        dispatchTimer?.cancel()
        dispatchTimer = nil
        print("Stop Notification Called")
    }
}

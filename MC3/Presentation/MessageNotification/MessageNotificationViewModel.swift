//
//  MessageNotificationViewModel.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 15/08/24.
//

import Foundation

class MessageNotificationViewModel: ObservableObject {
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
}

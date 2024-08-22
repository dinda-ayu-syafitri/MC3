//
//  StatusTrackViewModel.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import Foundation
import MessageUI
import SwiftUI

class StatusTrackViewModel: ObservableObject {
    @Published var isSheetOpened: Bool = false
    @Published var status: Int = 1

    func makeCall(phoneNumber: String) {
//        let phoneNumber = phoneNumber
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
            print("Attempting to call: \(phoneNumber)")
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        } else {
            print("Failed to create URL for the phone number.")
        }
    }
}

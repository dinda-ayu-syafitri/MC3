//
//  StatusTrackViewModel.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import Foundation
import SwiftUI
import MessageUI

class StatusTrackViewModel: ObservableObject {
    @Published var isSheetOpened: Bool = false
    @Published var status: Int = 1
    
    func makeCall() {
        let phoneNumber = "+6281385316329"
        if let phoneURL = URL(string: "tel://\(phoneNumber)") {
            print("Attempting to call: \(phoneNumber)")
            UIApplication.shared.open(phoneURL, options: [:], completionHandler: nil)
        } else {
            print("Failed to create URL for the phone number.")
        }
    }
}

//
//  TrackingViewModel.swift
//  Pulse Watch
//
//  Created by Michelle Chau on 22/08/24.
//

import Foundation
import SwiftUI

class TrackingViewModel: ObservableObject {
    static var shared = TrackingViewModel()
        
        @Published var emergencyContact: EmergencyContact
        
        private init() {
            let name = UserDefaults.standard.string(forKey: "EmergencyContactName") ?? "Unknown"
            let phone = UserDefaults.standard.string(forKey: "EmergencyContactPhone") ?? "0000000000"
            self.emergencyContact = EmergencyContact(fullName: name, phoneNumber: phone)
        }
        
        func updateEmergencyContact(name: String, phone: String) {
            emergencyContact = EmergencyContact(fullName: name, phoneNumber: phone)
        }
        
        func callEmergencyContact(openURL: OpenURLAction) {
            if let url = URL(string: "tel://\(emergencyContact.phoneNumber)") {
                openURL(url)
            }
        }
}


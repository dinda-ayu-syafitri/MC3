//
//  EmergencyContacts.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 18/08/24.
//

import Foundation
import SwiftData

@Model
class EmergencyContacts: Identifiable {
    var id = UUID()
    var emergencyContacts: [EmergencyContact]

    init(emergencyContacts: [EmergencyContact]) {
        self.emergencyContacts = emergencyContacts
    }
}

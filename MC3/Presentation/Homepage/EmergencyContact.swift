//
//  EmergencyContact.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 14/08/24.
//

import Foundation

struct EmergencyContact: Identifiable, Codable, Equatable, Hashable {
    var id = UUID()
    var fullName: String
    var phoneNumber: String
    var fcm: String?
    var isPrimary: Bool
}

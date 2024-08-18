//
//  EmergencyContact.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 14/08/24.
//

import Foundation
import SwiftData

@Model
class EmergencyContact: Codable, Equatable, Hashable {
    var id: UUID
    var fullName: String
    var phoneNumber: Int
    var fcm: String?
    var isPrimary: Bool
    
    init(id: UUID = UUID(), fullName: String, phoneNumber: Int, fcm: String? = nil, isPrimary: Bool = false) {
           self.id = id
           self.fullName = fullName
           self.phoneNumber = phoneNumber
           self.fcm = fcm
           self.isPrimary = isPrimary
       }

       // MARK: - Codable
       enum CodingKeys: String, CodingKey {
           case id, fullName, phoneNumber, fcm, isPrimary
       }

       required init(from decoder: Decoder) throws {
           let container = try decoder.container(keyedBy: CodingKeys.self)
           id = try container.decode(UUID.self, forKey: .id)
           fullName = try container.decode(String.self, forKey: .fullName)
           phoneNumber = try container.decode(Int.self, forKey: .phoneNumber)
           fcm = try container.decodeIfPresent(String.self, forKey: .fcm)
           isPrimary = try container.decode(Bool.self, forKey: .isPrimary)
       }

       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)
           try container.encode(id, forKey: .id)
           try container.encode(fullName, forKey: .fullName)
           try container.encode(phoneNumber, forKey: .phoneNumber)
           try container.encodeIfPresent(fcm, forKey: .fcm)
           try container.encode(isPrimary, forKey: .isPrimary)
       }

       // MARK: - Equatable
       static func == (lhs: EmergencyContact, rhs: EmergencyContact) -> Bool {
           return lhs.id == rhs.id
       }

       // MARK: - Hashable
       func hash(into hasher: inout Hasher) {
           hasher.combine(id)
       }
}

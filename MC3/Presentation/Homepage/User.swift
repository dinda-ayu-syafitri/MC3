//
//  User.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 14/08/24.
//

import Foundation
import SwiftData

//@Model
class User: Identifiable, Equatable, Hashable {
    var id: UUID
    var idFirebase: String
    var phoneNumber: Int?
    var fullName: String
    var fcm: String
    var emegencyContacts: [EmergencyContact]?
    
    init(id: UUID = UUID(), 
         idFirebase: String = "",
         phoneNumber: Int? = nil,
         fullName: String = "",
         fcm: String = "",
         emegencyContacts: [EmergencyContact]? = nil
    ) {
        self.id = id
        self.idFirebase = idFirebase
        self.phoneNumber = phoneNumber
        self.fullName = fullName
        self.fcm = fcm
        self.emegencyContacts = emegencyContacts
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

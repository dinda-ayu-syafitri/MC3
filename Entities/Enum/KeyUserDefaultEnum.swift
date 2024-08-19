//
//  KeyUserDefaultEnum.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import Foundation

enum KeyUserDefaultEnum {
    case email
    case idFirebase
    case status
    case roomLiveLocation
    case fullName
    case phoneNumber
    case fcm
}

extension KeyUserDefaultEnum {
    var toString: String {
        switch self {
        case .email:
            return "email"
        case .idFirebase:
            return "idFirebase"
        case .status:
            return "status"
        case .roomLiveLocation:
            return "roomLiveLocation"
        case .fullName:
            return "fullName"
        case .phoneNumber:
            return "phoneNumber"
        case .fcm:
            return "fcm"
        }
    }
}

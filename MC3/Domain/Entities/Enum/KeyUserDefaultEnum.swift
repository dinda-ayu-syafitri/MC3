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
    case pin
    case fullname
    case phoneNumber
    case fullName
    case fcm
    case locationPrivacy
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
        case .pin:
            return "pin"
        case .fullname:
            return "fullname"
        case .phoneNumber:
            return "phoneNumber"
        case .fullName:
            return "fullName"
        case .fcm:
            return "fcm"
        case .locationPrivacy:
            return "acceptLocationPrivacy"
        }
    }
}

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
    case roomLiveLocation
    case pin
    case fullname
    case phoneNumber
    case fullName
    case fcm
    case trackedStatus
    case locationPrivacy
    // MARK: Logic Views
    case statusBoarding
}

extension KeyUserDefaultEnum {
    var toString: String {
        switch self {
        case .email:
            return "email"
        case .idFirebase:
            return "idFirebase"
        case .statusBoarding:
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
        case .trackedStatus:
            return "trackedStatus"
        case .locationPrivacy:
            return "acceptLocationPrivacy"
        }
    }
}

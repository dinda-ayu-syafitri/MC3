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
        }
    }
}

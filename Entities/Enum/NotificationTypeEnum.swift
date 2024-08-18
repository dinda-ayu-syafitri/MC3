//
//  NotificationTypeEnum.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 18/08/24.
//

import Foundation

enum NotificationTypeEnum {
    case ABNORMALHEARTRATE
    case SOSALERT
}

extension NotificationTypeEnum {
    var toString: String {
        switch self {
        case .ABNORMALHEARTRATE:
            return "abnormalHeartRate"
        case .SOSALERT:
            return "sosAlert"
        }
    }
}

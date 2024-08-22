//
//  NotificationTypeEnum.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 18/08/24.
//

import Foundation

enum NotificationTypeEnumIos {
    case ABNORMALHEARTRATE
    case SOSALERT
    case USERTRACKED
}

extension NotificationTypeEnumIos {
    var toString: String {
        switch self {
        case .ABNORMALHEARTRATE:
            return "abnormalHeartRate"
        case .SOSALERT:
            return "sosAlert"
        case .USERTRACKED:
            return "userTracked"
        }
    }
}

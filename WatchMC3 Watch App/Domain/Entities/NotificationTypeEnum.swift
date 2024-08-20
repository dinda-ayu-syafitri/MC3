//
//  NotificationTypeEnum.swift
//  WatchMC3 Watch App
//
//  Created by Luthfi Misbachul Munir on 18/08/24.
//

import Foundation

enum NotificationTypeEnumWatch {
    case ABNORMALHEARTRATE
    case SOSALERT
}

extension NotificationTypeEnumWatch {
    var toString: String {
        switch self {
        case .ABNORMALHEARTRATE:
            return "abnormalHeartRate"
        case .SOSALERT:
            return "sosAlert"
        }
    }
}

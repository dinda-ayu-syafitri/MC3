//
//  FCMTokenManager.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 16/08/24.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()
    private init() {}

    var fcmToken: String?
}

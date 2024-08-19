//
//  NotificationHandler.swift
//  MC3
//
//  Created by Michelle Chau on 19/08/24.
//

import Foundation

class NotificationHandler {
    static let shared = NotificationHandler()
    private var homeViewModel: HomeViewModel?
    
    func setHomeViewModel(_ homeViewModel: HomeViewModel) {
        self.homeViewModel = homeViewModel
    }
    
    func handleOkayAction() {
        homeViewModel?.stopCountdown()
    }
}

//
//  CountdownManager.swift
//  MC3
//
//  Created by Michelle Chau on 19/08/24.
//

import Foundation

class CountdownManager: ObservableObject {
    @Published var timeRemaining: Int = 20
    @Published var countdownIsActive: Bool = false
//    var notifDelegate = NotificationDelegate()
    
    @Published var notifDelegate: NotificationDelegate
    
    init(notifDelegate: NotificationDelegate) {
        self.notifDelegate = notifDelegate
    }


    private var timer: Timer?
    
    func startCountdown() {
        countdownIsActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                print("Time remaining: \(self.timeRemaining)")
                
                if self.notifDelegate.triggerStopCD == true {
                    self.stopCountdown()
                }
                
            } else {
                self.stopCountdown()
            }
        }
    }
    
    func stopCountdown() {
        timer?.invalidate()
        timer = nil
        countdownIsActive = false
//        timeRemaining = 20
        print("Countdown stopped")
    }
    
}


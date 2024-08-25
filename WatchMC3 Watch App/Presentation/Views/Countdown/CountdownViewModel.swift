//
//  CountdownViewModel.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 20/08/24.
//

import Foundation

class CountdownViewModel: ObservableObject {
    static let shared = CountdownViewModel()
    
    @Published var timeRemaining: Int = 10
    @Published var countdownIsActive: Bool = false
    var router = RouterWatch.shared

    private var timer: Timer?
    
    func startCountdown() {
        if countdownIsActive { stopCountdown() }
        
//        timeRemaining = 20
        countdownIsActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            
            DispatchQueue.main.async {
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                    print("Time remaining: \(self.timeRemaining)")
                    
                } else {
                    self.stopCountdown()
                    HapticFeedbackManager.shared.stopContinuousHaptic()
                    if !HomeViewModel.shared.emergencySessionIsActive {
                        // Send message to iPhone when countdown expires
                            //            print("Countdown ends, sending message to iOS")
                        WatchToiOSConnector.shared.sendTriggerToiOS(notificationType: .SOSALERT)
                        // Stop countdown and mark emergency session as active
                        HomeViewModel.shared.emergencySessionIsActive = true
                        print("emergedncy session aktif? \(HomeViewModel.shared.emergencySessionIsActive)")
                        
                        self.router.navigateTo(.trackingView)
                        
                    }
                }
                
                
            }
        }
    }
    
    func stopCountdown() {
        guard countdownIsActive else { return } // Ensure the countdown is only stopped once

        timer?.invalidate()
        timer = nil
        countdownIsActive = false
        
        timeRemaining = 10 // Set countdown again
        HomeViewModel.shared.heartRates.removeAll() // Emptying array to reset HR data
        print("Countdown stopped")
    }
    
}

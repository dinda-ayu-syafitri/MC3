////
////  CountdownManager.swift
////  MC3
////
////  Created by Michelle Chau on 19/08/24.
////
//
//import Foundation
//
//class CountdownManager: ObservableObject {
//    
//    static let shared = CountdownManager()
//    
//    @Published var timeRemaining: Int = 20
//    @Published var countdownIsActive: Bool = false
//
//
//    private var timer: Timer?
//    
//    func startCountdown() {
//        if countdownIsActive {
//                stopCountdown()
//        }
//        
//        timeRemaining = 20
//        countdownIsActive = true
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            
//            DispatchQueue.main.async {
//                if self.timeRemaining > 0 {
//                    self.timeRemaining -= 1
//                    print("Time remaining: \(self.timeRemaining)")
//                    
//                    //                if self.notifDelegate.triggerStopCD == true {
//                    //                    self.stopCountdown()
//                    //                }
//                    
//                } else {
//                    self.stopCountdown()
////                    CountdownViewModel().sendSOSAlertToPhone()
//                }
//                
//                
//            }
//        }
//    }
//    
//    func stopCountdown() {
//        guard countdownIsActive else { return } // Ensure the countdown is only stopped once
//
//        timer?.invalidate()
//        timer = nil
//        countdownIsActive = false
////        timeRemaining = 20
//        print("Countdown stopped")
//    }
//    
//}
//

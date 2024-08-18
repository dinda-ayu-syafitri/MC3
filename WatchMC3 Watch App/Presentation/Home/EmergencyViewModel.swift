////
////  EmergencyViewModel.swift
////  WatchMC3 Watch App
////
////  Created by Michelle Chau on 15/08/24.
////
//
//import Foundation
//
//class EmergencyViewModel: ObservableObject {
//    @Published var countdownIsActive: Bool = false
//    @Published var timeRemaining: Int = 10
//    private var timer: Timer?
//    private var emergencySessionIsActive = false
//    private let heartRateViewModel: HeartRateViewModel
//    
//    init(heartRateViewModel: HeartRateViewModel) {
//        self.heartRateViewModel = heartRateViewModel
//    }
//    
//    // Check for emergency based on heart rate data
//    func checkEmergency() {
//        if heartRateViewModel.isStandardDeviationHigh() && !emergencySessionIsActive {
//            popUpNotif()
//            startCountdown()
//        }
//    }
//    
//    // Display notification
//    private func popUpNotif() {
//        if !countdownIsActive && !emergencySessionIsActive {
//            NotificationManager.shared.scheduleNotification(
//                title: "High Heart Rate",
//                body: "Your heart rate is at \(Int(heartRateViewModel.heartRateModel.heartRate)) BPM. SOS message will be sent in (countdown)",
//                category: "SOS_Category"
//            )
//        }
//    }
//    
//    // Start countdown timer
//    func startCountdown() {
//        countdownIsActive = true
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//            if self.timeRemaining > 0 {
//                self.timeRemaining -= 1
//                print("Time remaining: \(self.timeRemaining)")
//            } else {
//                self.sendSOSMessage()
//            }
//        }
//    }
//    
//    // Stop countdown timer
//    func stopCountdown() {
//        timer?.invalidate()
//        timer = nil
//        countdownIsActive = false
//        timeRemaining = 10 // Reset the countdown timer
//    }
//    
//    // Send SOS message to iPhone
//    private func sendSOSMessage() {
//        print("Countdown ends, sending message to iOS")
//        WatchToiOSConnector.shared.sendTriggerToiOS()
//        stopCountdown()
//        emergencySessionIsActive = true
//    }
//}
//

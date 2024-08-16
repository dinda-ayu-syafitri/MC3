//
//  HeartRateViewModel.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 13/08/24.
//

import Foundation
import HealthKit

class HeartRateViewModel: ObservableObject {
    @Published var heartRateModel: HeartRateModel = HeartRateModel(heartRate: 0.0)
    @Published var isEnableBackgroundDelivery: Bool = false {
        didSet {
            UserDefaults.standard.set(isEnableBackgroundDelivery, forKey: "isEnableBackgroundDelivery") }
    }
    @Published var countdownIsActive: Bool = false
    @Published var timeRemaining: Int = 10
    private var timer: Timer?
    var messageViewModel = MessageNotificationViewModel()

    private var heartRate: Double = 0.0
    private var heartRates: [Double] = []
        
//    private var emergencySessionIsActive = false
    let router: Router
    
    init() {
        isEnableBackgroundDelivery = UserDefaults.standard.bool(forKey: "isEnableBackgroundDelivery")
        self.router = Router()
        toggleBackgroundTracking()
    }
    
    //fetch heart rate data (foreground tracking)
    func fetchHeartRateDataForeground() {
        HeartRateManager.shared.fetchHeartRateData { [weak self] samples in
            self?.process(samples)
        }
    }
    
    //fetch heart rate data (background tracking)
    func fetchHeartRateDataBackground() {
        HeartRateManager.shared.startBackgroundTracking { [weak self] samples in
            self?.process(samples)}
    }
    
    //stop fetch heart rate data (background tracking)
    func stopFetchHeartRateDataBackground() {
        HeartRateManager.shared.stopBackgroundTracking()
    }
    
    //process the retrieved samples
    private func process(_ samples: [HKSample]?) {
        guard let samples = samples as? [HKQuantitySample] else {return}
        DispatchQueue.main.async {
            self.heartRate = samples.last?.quantity.doubleValue(for: .count().unitDivided(by: .minute())) ?? 0.0
            
            //handling store heart rate
            self.storeHeartRateHandling()
            
            //check emergency state
            self.checkEmergency()
        }
    }
    
    //allow automatic alert toggle
    private func toggleBackgroundTracking() {
        isEnableBackgroundDelivery ?
        fetchHeartRateDataBackground() : fetchHeartRateDataForeground()
    }
    
    
    //TODO: bisa dipindahin ke file tesendiri?
    //heart rate handling
    func storeHeartRateHandling() {
        if heartRate != 0.0 {
            // Check if current array empty
            if heartRates.isEmpty {
                heartRates.append(heartRate)
                print("countdown is active: \(countdownIsActive)")
//                print("emergency session is active: \(emergencySessionIsActive)")

            } // Check if current Heart Rate is equals to previous Heart Rate
            else if !heartRates[heartRates.count - 1].isEqual(to: heartRate) {
                // TODO: Uncomment when need to debug (print array)
                print ("Data count: \(self.heartRates.count)")
                print(heartRates.items)
                print("check session reachable : \(WatchToiOSConnector.shared.session.isReachable)")
                // Check if current heart rate is Delta High and current array has only 1 Data
                if heartRates.count < 2 && isDeltaHigh(currentHeartRate: heartRate, previousHeartRate: heartRates[0]) {
                    heartRates.append(heartRate)
                    // Because already checked delta high we only need to store next data
                } else if heartRates.count >= 2 {
                    heartRates.append(heartRate)
                } // Remove previous data if its not delta high and current array only contains 1 data
                else {
                    heartRates.append(heartRate)
                    heartRates.remove(at: 0)
                }
            }
            // Display to FE if current heartRate is not 0
            heartRateModel.heartRate = heartRate
        }
    }
    
    //check delta
    func isDeltaHigh(currentHeartRate: Double, previousHeartRate: Double) -> Bool {
        let threshold = 1.0
        let delta = abs(previousHeartRate - currentHeartRate)
        if delta >= threshold {
            return true
        }
        return false
    }
    
    //check sd
    func isStandardDeviationHigh() -> Bool {
        let threshold = 1.0
        // Check if array already contains 10 data
        if heartRates.count == 3 {
            /**
             Count Standard Deviation
             1. Count Mean of the heart rate data
             2. Store all variance of 10 data (heartRate-mean)^2
             3. Count total variance and divide by total data - 1
             */
            let mean = heartRates.reduce(0, +) /  Double(heartRates.count)
            var varianceList: [Double] = []
            for heartRate in heartRates {
                let variance = pow(heartRate - mean, 2)
                varianceList.append(variance)
            }
            let sd = varianceList.reduce(0, +) / Double(heartRates.count - 1)
            // Remove current data in array since it already been used
            heartRates.removeAll()
            print("removed data") //DEBUG
            if sd > threshold {
                print("sd > threshold")
                return true
            }
            return false
        }
        return false
    }
    
    //check emergency
    func checkEmergency() {
        if isStandardDeviationHigh() /*&& !emergencySessionIsActive*/ {

            //pop up notif to user
//            self.isLikelyInEmergency = true
            self.popUpNotif()
            WatchToiOSConnector.shared.sendTriggerToiOS()

            
//            self.startCountdown()
        }
//        if self.timeRemaining == 0 /*&& !emergencySessionIsActive*/ {
//            print("Countdown ends, sending message to iOS")
//            // Send message to iPhone when countdown expires
//            WatchToiOSConnector.shared.sendTriggerToiOS()
//            // Stop countdown and mark emergency session as active
//            self.stopCountdown()
////            self.emergencySessionIsActive = true
//        }
    }
    
//    func popUpConnector() {
//        print("pop up connector")
//        
//        if  !countdownIsActive && !emergencySessionIsActive {
//            print("Masuk Popup connector ges")
//            WatchToiOSConnector.shared.sendTriggerToiOS()
//        }
//    }
    
    //pop up notification
    func popUpNotif()  {
//        print("countdown is active \(countdownIsActive)")
//        print("Emergency session is active \(emergencySessionIsActive)")
       
//        if  !countdownIsActive /*&& !emergencySessionIsActive*/ {
            print("Masuk Popup ges")
            NotificationManager.shared.scheduleNotificationPopUp(
                title: "High Heart Rate",
                body: "test",
//                body: "Your heart rate is at \(Int(self.heartRateModel.heartRate)) BPM. SOS message will be sent in (coundown)",
                category: "SOS_Category"
            )

        messageViewModel.sendPushNotification(token: "dOBwwUKgGk2DsuqKBehzRm:APA91bFiskcpmyBJ8KUlZR4gkid1vjFrKCum3WeNZzXJkNccyhktizZXj8hEL45rDssGT121ldhlSduipOLsbxExKG5eDzuEKBmlnzojcDCnpRJU7N76l5-2mjnUOrdGjeAj16MJjudo", title: "Helppp!!! Wooiii", body: "Notif dari watch ke hp ke receiver", locationLink: "Ini nanti locaation link", senderFCM: "sender fcm")
//        }
        
    }
    
    // Start countdown timer
    func startCountdown() {
        self.countdownIsActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1

                print("Time remaining: \(self.timeRemaining)")
            }
        }
    }
    
    // Stop countdown timer
    func stopCountdown() {
        timer?.invalidate()
        timer = nil
        countdownIsActive = false
        timeRemaining = 10 // Reset the countdown timer
    }
}

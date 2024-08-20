//
//  HomeViewModel.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 13/08/24.
//

import Foundation
import HealthKit

class HomeViewModel: ObservableObject {
    static let shared = HomeViewModel()
    var delegate = NotificationDelegate()
//    @Published var router: RouterWatch = RouterWatch()
    @Published var triggerCountDownView = false
    
    @Published var heartRate: Double = 0.0
    @Published var isEnableBackgroundDelivery: Bool = false {
        didSet {
            toggleBackgroundTracking()
            UserDefaults.standard.set(isEnableBackgroundDelivery, forKey: "isEnableBackgroundDelivery") }
    }
    @Published var isCountdownViewPresented: Bool = false
    private var heartRates: [Double] = []
    var messageViewModel = MessageNotificationViewModel()
    var countdownManager: CountdownManager
    private var emergencySessionIsActive = false
    
    
    init() {
        isEnableBackgroundDelivery = UserDefaults.standard.bool(forKey: "isEnableBackgroundDelivery")
        self.countdownManager = CountdownManager(notifDelegate: self.delegate)
        toggleBackgroundTracking()
    }
    
    func createNotification(notificationType: NotificationTypeEnum) {
        WatchToiOSConnector.shared.sendTriggerToiOS(notificationType: notificationType)
    }
    
    //process the retrieved samples
    private func process(_ samples: [HKSample]?) {
        guard let samples = samples as? [HKQuantitySample] else {return}
        
        DispatchQueue.main.async {
            self.heartRate = samples.last?.quantity.doubleValue(for: .count().unitDivided(by: .minute())) ?? 0.0
            //handling store heart rate
            //            self.storeHeartRateHandling()
            self.storeHeartRateHandling2()
            //check emergency state
            self.checkEmergency()
        }
    }
    
    //allow automatic alert toggle
    private func toggleBackgroundTracking() {
        isEnableBackgroundDelivery ?
        fetchHeartRateDataBackground() : fetchHeartRateDataForeground()
    }
    
    func goToCD(router: RouterWatch) {
        router.navigateTo(.countdownView)
    }
    
    
    //TODO: bisa dipindahin ke file tesendiri?
    //heart rate handling
    func storeHeartRateHandling2() {
        if heartRate != 0.0 && heartRates.count < 5 && !countdownManager.countdownIsActive && !emergencySessionIsActive {
            if heartRates.isEmpty {
                heartRates.append(heartRate)
                print ("Data count: \(self.heartRates.count)")
                print(heartRates.items)
            } else if !heartRates[heartRates.count - 1].isEqual(to: heartRate) {
                heartRates.append(heartRate)
                print ("Data count: \(self.heartRates.count)")
                print(heartRates.items)
            }
        }
    }
    
    
    func storeHeartRateHandling() {
        if heartRate != 0.0 && !countdownManager.countdownIsActive && !emergencySessionIsActive {
            // Check if current array empty
            if heartRates.isEmpty {
                heartRates.append(heartRate)
                print("countdown is active: \(countdownManager.countdownIsActive)")
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
            self.heartRate = heartRate
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
        if heartRates.count == 5 {
            let mean = heartRates.reduce(0, +) /  Double(heartRates.count)
            var varianceList: [Double] = []
            for heartRate in heartRates {
                let variance = pow(heartRate - mean, 2)
                varianceList.append(variance)
            }
            let sd = varianceList.reduce(0, +) / Double(heartRates.count - 1)
            if sd > threshold {
                return true
            }
            heartRates.remove(at: 0)
            return false
        }
        return false
    }
    
    //check emergency
    func checkEmergency() {
        if isStandardDeviationHigh() && !countdownManager.countdownIsActive && !emergencySessionIsActive {
            heartRates.removeAll()
            self.createNotification(notificationType: .ABNORMALHEARTRATE)
            
//            router.navigateTo(.countdownView)
            triggerCountDownView = true
            countdownManager.startCountdown()
            
        }
        if countdownManager.timeRemaining == 0 && !emergencySessionIsActive {
            print("Countdown ends, sending message to iOS")
            // Send message to iPhone when countdown expires
            self.createNotification(notificationType: .SOSALERT)
            // Stop countdown and mark emergency session as active
            countdownManager.stopCountdown()
            self.emergencySessionIsActive = true
        }
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
}

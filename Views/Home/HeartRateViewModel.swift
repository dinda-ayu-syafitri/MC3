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
    @Published var isEnableBackgroundDelivery = false {
        didSet {
            toggleBackgroundTracking()
            UserDefaults.standard.set(isEnableBackgroundDelivery, forKey: "isEnableBackgroundDelivery")
        }
    }
    @Published var isSOSCountdownActive: Bool = false
    private var heartRateTemp: Double = 0.0
    @Published var sendSOSAlert: Bool = false
    
    
    init() {
        isEnableBackgroundDelivery = UserDefaults.standard.bool(forKey: "isEnableBackgroundDelivery")
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
            self.heartRateTemp = samples.last?.quantity.doubleValue(for: .count().unitDivided(by: .minute())) ?? 0.0
            //handling heart rate
            self.heartRateHandling()
        }
    }
    
    //allow automatic alert toggle
    private func toggleBackgroundTracking() {
        if isEnableBackgroundDelivery {
            fetchHeartRateDataBackground()
        } else {
            stopFetchHeartRateDataBackground()
        }
    }
    
    //heart rate handling
    func heartRateHandling() {
        if heartRateTemp != 0.0 && heartRateTemp != heartRateModel.heartRate {
            heartRateModel.heartRate = heartRateTemp
            //DEBUG
            self.notif()
        }
    }
    
    //print notification (DEBUG)
    func notif() {
        print("heartrate: \(heartRateModel.heartRate)")
        if self.heartRateModel.heartRate >= 70 {
            //            print("High heart rate detected. Alerting SOS in (countdown)")
            NotificationManager.shared.scheduleNotification(
                title: "High Heart Rate",
                body: "Your heart rate is at \(Int(self.heartRateModel.heartRate)) BPM. SOS message will be sent in (coundown)",
                category: "SOS_Category")
        }
    }
    
}


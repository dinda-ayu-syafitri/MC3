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
    
    //start observing heart rate changes
    func fetchHeartRateData() {
        HeartRateManager.shared.startHeartRateMonitoring { [weak self] samples in
            self?.process(samples)
        }
    }
    
    //process the retrieved samples
    private func process(_ samples: [HKSample]?) {
        guard let samples = samples as? [HKQuantitySample] else {return}
        DispatchQueue.main.async {
            self.heartRateModel.heartRate = samples.last?.quantity.doubleValue(for: .count().unitDivided(by: .minute())) ?? 0.0
            //notif
            self.notif()
        }
    }
    
    //print notification
    func notif() {
        print("heartrate: \(heartRateModel.heartRate)")
        if self.heartRateModel.heartRate >= 70 {
            print("High heart rate detected. Alerting SOS in (countdown)")
        }
    }
    
}


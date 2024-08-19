//
//  HealthKitManager.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 13/08/24.
//

import Foundation
import HealthKit

class HealthKitManager: ObservableObject {
    let healthStore = HKHealthStore()
    @Published var isAuthorized: Bool = false
    
    //request HealthKit authorization
    func requestAuthorization() {
        //check whether Healthkit data available on this device
        guard HKHealthStore.isHealthDataAvailable() else { return }
        
        //define type of health data to read or write (heart rate)
        let sampleToRead: Set = [
            HKQuantityType(.heartRate)
        ]
        
        //request authorization to read or write the health data
        healthStore.requestAuthorization(toShare: [], read: sampleToRead) { (success, error) in
            DispatchQueue.main.async {
                // check the authorization status
                if success {
                    print("HealthKit authorization successful.")
                    self.isAuthorized = true
                } else {
                    print("HealthKit authorization failed.")
                    self.isAuthorized = false
                }
            }
        }
     
    }
    
}

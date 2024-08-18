//
//  HeartRateManager.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 13/08/24.
//

import HealthKit

class HeartRateManager {
    
    static let shared = HeartRateManager()
    private let healthStore = HKHealthStore()
    let heartRateType = HKQuantityType(.heartRate)
    private var observerQuery: HKObserverQuery?
    
    //    let sevenMinutesAgo = Calendar.current.date(byAdding: .minute, value: -7, to: Date())
    
    func fetchHeartRateData(completion: @escaping ([HKSample]?) -> Void) {
        
        let predicate = HKQuery.predicateForSamples(withStart: Date(), end: nil, options: .strictStartDate)
        
        let query = HKAnchoredObjectQuery(type: heartRateType, predicate: predicate, anchor: nil, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, newAnchor, error) in
            completion(samples)
        }
        
        query.updateHandler = { (query, samples, deletedObjects, newAnchor, error) in
            completion(samples)
        }
        
        healthStore.execute(query)
    }
    
    
    func startBackgroundTracking(completion: @escaping ([HKSample]?) -> Void) {
        guard observerQuery == nil else {return}
        
        //start the observer query to do background tracking
        observerQuery = HKObserverQuery(sampleType: heartRateType, predicate: nil) { [weak self] (query, completionHandler, error) in
            if let error = error {
                print("Observer query error: \(error.localizedDescription)")
                return
            }
            
            //fetch the latest data when there's new data
            self?.fetchHeartRateData(completion: completion)
            
            //call the completion handler to let HealthKit know the processing is done
            completionHandler()
        }
        
        
        if let observerQuery = observerQuery {
            healthStore.execute(observerQuery)
            
            // Enable background delivery of heart rate data updates
            healthStore.enableBackgroundDelivery(for: heartRateType, frequency: .immediate) { success, error in
                if success {
                    print("Background delivery enabled")
                } else {
                    print("Failed to enable background delivery: \(String(describing: error))")
                }
            }
        }
    }
    
    func stopBackgroundTracking() {
        if let observerQuery = observerQuery {
            healthStore.stop(observerQuery)
            self.observerQuery = nil
        }
        
        healthStore.disableAllBackgroundDelivery { success, error in
            if success {
                print("Background delivery disabled")
            } else {
                print("Failed to disable background delivery: \(String(describing: error))")
            }
        }
    }
}

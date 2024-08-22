//
//  BackgroundTaskManager.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 21/08/24.
//

import BackgroundTasks
import CoreLocation

class BackgroundTaskManager {
    static let shared = BackgroundTaskManager()
    private let locationManager = CLLocationManager()

    private init() {
        BGTaskScheduler.shared.register(forTaskWithIdentifier: "MC3.Untouchable", using: nil) { task in
            self.handleAppRefresh(task: task as! BGAppRefreshTask)
        }
    }

    func scheduleBackgroundTask() {
        let request = BGAppRefreshTaskRequest(identifier: "MC3.Untouchable")
        request.earliestBeginDate = Date(timeIntervalSinceNow: 1 * 60) // Fetch every 1 minutes
        
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Failed to schedule background task: \(error)")
        }
    }

    func handleAppRefresh(task: BGAppRefreshTask) {
        locationManager.startUpdatingLocation()
        
        task.setTaskCompleted(success: true)
    }
}

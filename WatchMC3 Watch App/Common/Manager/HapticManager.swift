//
//  HapticManager.swift
//  Pulse Watch
//
//  Created by Michelle Chau on 23/08/24.
//

import Foundation
import WatchKit

class HapticFeedbackManager {
    private var hapticTimer: Timer?
    static let shared = HapticFeedbackManager()
    
    // Start continuous haptic feedback
    func startContinuousHaptic(interval: TimeInterval = 0.5) {
        stopContinuousHaptic() // Ensure any existing haptic feedback is stopped
        
        hapticTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { _ in
            WKInterfaceDevice.current().play(.notification)
        }
    }
    
    // Stop continuous haptic feedback
    func stopContinuousHaptic() {
        hapticTimer?.invalidate()
        hapticTimer = nil
    }
}

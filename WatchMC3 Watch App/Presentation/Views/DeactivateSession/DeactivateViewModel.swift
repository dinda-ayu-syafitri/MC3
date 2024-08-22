//
//  DeactivateViewModel.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 18/08/24.
//

import Foundation

class DeactivateViewModel: ObservableObject {
    @Published var enteredPin: [String] = []
    @Published var isPinCorrect = true
    @Published var pinMessage = "Enter pin"
    private let correctPin = ["1", "2", "3", "4"] // The correct PIN (contoh)
    
    func handlePinEntry(_ digit: String) {
        guard enteredPin.count < 4 else { return }
        enteredPin.append(digit)
        
        if enteredPin.count == 4 {
            checkPin()
        }
    }
    
    func deleteLastDigit() {
        if !enteredPin.isEmpty {
            enteredPin.removeLast()
        }
    }
    
    private func checkPin() {
        if enteredPin == correctPin {
            // Correct PIN entered
            pinMessage = "PIN Correct"
            isPinCorrect = true
            // Perform the action for correct PIN:
            RouterWatch.shared.navigateTo(.homeView)
            HomeViewModel.shared.emergencySessionIsActive = false
            
        } else {
            // Incorrect PIN entered, reset and show error
            pinMessage = "Wrong PIN"
            isPinCorrect = false
            enteredPin.removeAll()
        }
    }
}


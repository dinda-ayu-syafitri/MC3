//
//  DeactivateViewModel.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import Foundation

class DeactivateViewModel: ObservableObject {
    private var savedPin: String
    @Published var isMatched: Bool = false
    @Published var stringChecked: String = "The pin doesn't correct"
    @Published var pin: String = "" {
        didSet {
            self.checkPin()
        }
    }
    
    private var userDefaultUseCase: UserDefaultUseCaseProtocol
    
    init(userDefaultUseCase: UserDefaultUseCaseProtocol) {
        self.userDefaultUseCase = userDefaultUseCase
        self.savedPin = userDefaultUseCase.getData(key: .pin) as! String
    }
    
    private func checkPin() {
        if (self.pin.count == 4) && (self.pin == self.savedPin) {
            print("here")
            self.isMatched = true
            self.stringChecked = "The Password Matched"
            Router.shared.popToRoot()
        } else {
            self.isMatched = false
            self.stringChecked = "The pin doesn't correct"
        }
    }
}

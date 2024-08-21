//
//  PersonalPinViewModel.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import Foundation

class PersonalPinViewModel: ObservableObject {
    @Published var isCorrect: Bool = false {
        didSet {
            if self.isCorrect {
                self.stringCheck = "Already matched"
            } else {
                self.stringCheck = "Make sure the password match"
            }
        }
    }
    @Published var isTyping: Bool = false
    @Published var personalPin: String = ""
    @Published var stringCheck: String = "Make sure the password match"
    @Published var confirmPersonalPin: String = "" {
        didSet {
            self.isCorrect = self.checkSamePin()
        }
    }
    
    private var userDefaultUseCase: UserDefaultUseCaseProtocol
    
    init(userDefaultUseCase: UserDefaultUseCaseProtocol) {
        self.userDefaultUseCase = userDefaultUseCase
    }
    
    func checkSamePin() -> Bool {
        return self.personalPin == self.confirmPersonalPin
    }
    
    func saveToUserDefault() {
        userDefaultUseCase.saveData(data: self.personalPin, key: .pin)
        print("data: \(String(describing: userDefaultUseCase.getData(key: .pin)))")
    }
}

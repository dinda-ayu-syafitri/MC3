//
//  PersonalPinViewModel.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import Foundation

class PersonalPinViewModel: ObservableObject {
    @Published var isCorrect: Bool = false
    @Published var isTyping: Bool = false
    @Published var personalPin: String = ""
    @Published var confirmPersonalPin: String = "" {
        didSet {
            self.isCorrect = self.checkSamePin()
        }
    }
    
    func checkSamePin() -> Bool {
        return self.personalPin == self.confirmPersonalPin
    }
}

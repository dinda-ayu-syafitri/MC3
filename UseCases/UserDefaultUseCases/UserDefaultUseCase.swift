//
//  UserDefaultUseCase.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import Foundation

class UserDefaultUseCase: UserDefaultUseCaseProtocol {
    private let userDefaultRepository: UserDefaultRepositoryProtocol
    init(userDefaultRepository: UserDefaultRepositoryProtocol) {
        self.userDefaultRepository = userDefaultRepository
    }
    
    func saveLoginData(email: String, firebaseID: String) {
        userDefaultRepository.saveData(data: email, key: .email)
        userDefaultRepository.saveData(data: firebaseID, key: .idFirebase)
        userDefaultRepository.saveData(data: true, key: .status)

    }
    
    func clearDataWhenLogOut(email: String, firebaseID: String) {
        userDefaultRepository.deleteData(key: .email)
        userDefaultRepository.deleteData(key: .idFirebase)
        userDefaultRepository.deleteData(key: .status)
    }
}

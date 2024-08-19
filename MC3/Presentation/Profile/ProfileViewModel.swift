//
//  ProfileViewModel.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 19/08/24.
//

import FirebaseAuth
import Foundation

class ProfileViewModel: ObservableObject {
    @Published var nonce: String = ""
    @Published var isLoading: Bool = false
    @Published var userModel: User = .init()
    private var firebaseUseCase: FirebaseServiceUseCaseProtocol
    private var userDefaultUseCase: UserDefaultUseCaseProtocol

    let firebaseID = Auth.auth().currentUser?.uid

    init(firebaseUseCase: FirebaseServiceUseCaseProtocol, userDefaultUseCase: UserDefaultUseCaseProtocol) {
        self.firebaseUseCase = firebaseUseCase
        self.userDefaultUseCase = userDefaultUseCase
    }

    func saveProfileData(fullName: String, phoneNumber: String) async {
        self.userDefaultUseCase.saveProfileData(fullName: fullName, phoneNumber: phoneNumber)
    }

    func updateProfileData(fullName: String, phoneNumber: String) async {
        do {
            try await self.firebaseUseCase.updateProfileData(idFirestore: self.firebaseID ?? "", fullName: fullName, phoneNumber: phoneNumber)
        } catch {
            print("error while registering on vm : \(error.localizedDescription)")
        }
    }
}

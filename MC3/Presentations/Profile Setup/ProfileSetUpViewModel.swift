//
//  ProfileSetUpViewModel.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import FirebaseAuth
import Foundation

class ProfileSetUpViewModel: ObservableObject {
    @Published var fromSetting: Bool = false
    @Published var fullName: String = "" {
        didSet {
            self.isFilled()
        }
    }
    @Published var phoneNumber: String = ""{
        didSet {
            self.isFilled()
        }
    }
    @Published var activateSubmit: Bool = false
    private var firebaseUseCase: FirebaseServiceUseCaseProtocol
    private var userDefaultUseCase: UserDefaultUseCaseProtocol
    
    let firebaseID = Auth.auth().currentUser?.uid
    
    init(firebaseUseCase: FirebaseServiceUseCaseProtocol, userDefaultUseCase: UserDefaultUseCaseProtocol) {
        self.firebaseUseCase = firebaseUseCase
        self.userDefaultUseCase = userDefaultUseCase
    }
    
    func submitProfileSetUp() async {
        self.phoneNumber = self.phoneNumber.standardizedPhoneNumber()
        await self.saveProfileToLocal()
        await self.updateProfileToFirebase()
        
        print("name: \(String(describing: userDefaultUseCase.getData(key: .fullname)))")
        print("phone: \(String(describing: userDefaultUseCase.getData(key: .phoneNumber)))")
    }
    
    private func isFilled() {
        if !self.fullName.isEmpty && !self.phoneNumber.isEmpty {
            self.activateSubmit = true
        } else {
            self.activateSubmit = false
        }
    }
    
    private func saveProfileToLocal() async {
        self.userDefaultUseCase.saveProfileData(fullName: self.fullName, phoneNumber: self.phoneNumber)
        self.userDefaultUseCase.saveData(data: 3, key: .statusBoarding)
    }
    
    private func updateProfileToFirebase() async {
        do {
            try await firebaseUseCase.updateProfileData(idFirestore: self.firebaseID ?? "", fullName: self.fullName, phoneNumber: self.phoneNumber)
        } catch {
            print("error while registering on vm : \(error.localizedDescription)")
        }
    }
}

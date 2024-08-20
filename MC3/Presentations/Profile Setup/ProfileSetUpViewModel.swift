//
//  ProfileSetUpViewModel.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import FirebaseAuth
import Foundation

class ProfileSetUpViewModel: ObservableObject {
    @Published var nonce: String = ""
    @Published var isLoading: Bool = false
    @Published var userModel: User = .init()
    @Published var fullName: String = ""
    @Published var phoneNumber: String = ""
    private var firebaseUseCase: FirebaseServiceUseCaseProtocol
    private var userDefaultUseCase: UserDefaultUseCaseProtocol
    
    let firebaseID = Auth.auth().currentUser?.uid
    
    init(firebaseUseCase: FirebaseServiceUseCaseProtocol, userDefaultUseCase: UserDefaultUseCaseProtocol) {
        self.firebaseUseCase = firebaseUseCase
        self.userDefaultUseCase = userDefaultUseCase
    }
    
    func submitProfileSetUp() async {
        await self.saveProfileToLocal()
        await self.updateProfileToFirebase()
        
        print("name: \(String(describing: userDefaultUseCase.getData(key: .fullname)))")
        print("phone: \(String(describing: userDefaultUseCase.getData(key: .phoneNumber)))")
    }
    
    private func saveProfileToLocal() async {
        self.userDefaultUseCase.saveProfileData(fullName: self.fullName, phoneNumber: self.phoneNumber)
    }
    
    private func updateProfileToFirebase() async {
        do {
            try await firebaseUseCase.updateProfileData(idFirestore: self.firebaseID ?? "", fullName: self.fullName, phoneNumber: self.phoneNumber)
        } catch {
            print("error while registering on vm : \(error.localizedDescription)")
        }
    }
}

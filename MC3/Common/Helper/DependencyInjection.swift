//
//  DependencyInjection.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 14/08/24.
//

import Foundation

// Grouping UseCase ke dalam satu fungsi
class DependencyInjection: ObservableObject {
    static let shared = DependencyInjection()

    private init() {}

//    private var modelContext: ModelContext?
//    func initializer(modelContext: ModelContext) {
//        self.modelContext = modelContext
//    }
//

    // MARK: IMPLEMENTATION OF FIREBASE SERVICE

    lazy var firebaseDataSource = FirebaseServiceDataSource()
    lazy var firebaseRepository = FirebaseServiceRepository(firebaseServiceDataSource: firebaseDataSource)
    lazy var firebaseUseCase = FirebaseServiceUseCase(firebaseServiceRepository: firebaseRepository)

    // MARK: IMPLEMENTATION OF USER DEFAULT SERVICE

    lazy var userDefaultDataSource = UserDefaultDataSource()
    lazy var userDefaultRepository = UserDefaultRepository(userDefaultDataSource: userDefaultDataSource)
    lazy var userDefaultUseCase = UserDefaultUseCase(userDefaultRepository: userDefaultRepository)

    // MARK: FUNCTIONS VIEW MODEL

    func loginViewModel() -> LoginViewModel {
        LoginViewModel(
            firebaseUseCase: firebaseUseCase,
            userDefaultUseCase: userDefaultUseCase
        )
    }
    
    // MARK: FUNCTIONS PIN INPUT VIEW MODEL
    func personalPinViewModel() -> PersonalPinViewModel {
        PersonalPinViewModel(userDefaultUseCase: userDefaultUseCase)

    func profileViewModel() -> ProfileViewModel {
        ProfileViewModel(
            firebaseUseCase: firebaseUseCase,
            userDefaultUseCase: userDefaultUseCase
        )
    }

    func emergencyContactsViewModel() -> EmergencyContactViewModel {
        EmergencyContactViewModel(
            firebaseUseCase: firebaseUseCase
        )
    }
}

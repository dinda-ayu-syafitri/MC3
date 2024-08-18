//
//  FirebaseServiceUseCase.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 14/08/24.
//

import Foundation

class FirebaseServiceUseCase: FirebaseServiceUseCaseProtocol {
    private let firebaseServiceRepository: FirebaseServiceRepositoryProtocol
    init(firebaseServiceRepository: FirebaseServiceRepositoryProtocol) {
        self.firebaseServiceRepository = firebaseServiceRepository
    }

    func registerAccount(idFirestore: String, fcm: String) async throws {
        let data = [
            "idFirestore": idFirestore,
            "fcm": fcm,
        ] as [String: Any]

        try await firebaseServiceRepository.submitDataWithIDFirebase(idFirestore: idFirestore, data: data)
    }

    func insertUserEmergencyContacts(idFirestore: String, emergencyContacts: [EmergencyContact]) async throws {
        let emergencyContactsData = try emergencyContacts.map { contact in
            let data = try JSONEncoder().encode(contact)
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        }

        let data = [
            "emergencyContacts": emergencyContactsData,
        ]

        try await firebaseServiceRepository.submitDataWithIDFirebase(idFirestore: idFirestore, data: data)
    }

    func submitDataWithIDFirebase(idFirestore: String, data: [String: Any]) async throws {
        try await firebaseServiceRepository.submitDataWithIDFirebase(idFirestore: idFirestore, data: data)
    }
}

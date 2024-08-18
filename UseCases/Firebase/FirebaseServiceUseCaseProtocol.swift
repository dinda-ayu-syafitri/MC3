//
//  FirebaseServiceUseCase.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 14/08/24.
//

import Foundation

protocol FirebaseServiceUseCaseProtocol {
    func submitDataWithIDFirebase(idFirestore: String, data: [String: Any]) async throws
    func registerAccount(idFirestore: String, fcm: String) async throws
    func insertUserEmergencyContacts(idFirestore: String, emergencyContacts: [EmergencyContact]) async throws
}

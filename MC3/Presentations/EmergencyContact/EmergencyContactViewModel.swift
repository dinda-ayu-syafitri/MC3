//
//  EmergencyContactViewModel.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 15/08/24.
//

import Contacts
import Foundation
import SwiftData

class EmergencyContactViewModel: ObservableObject {
    @Published var contacts: [CNContact] = []
    private var firebaseUseCase: FirebaseServiceUseCaseProtocol

    init(firebaseUseCase: FirebaseServiceUseCaseProtocol) {
        self.firebaseUseCase = firebaseUseCase
    }

    func fetchAllContacts() async {
        let store = CNContactStore()

        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)

        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { contact,
                    _ in
                self.contacts.append(contact)
            })
        } catch {
            print("Error fetcch all contact")
        }
    }

    func SaveLocalEmergencyContacts(context: ModelContext, emergencyContacts: [EmergencyContact]) {
        let formattedEmergencyContacts = EmergencyContacts(emergencyContacts: emergencyContacts)
        context.insert(formattedEmergencyContacts)
    }

    func insertUserEmergencyContacts(idFirestore: String, emergencyContacts: [EmergencyContact]) async {
        do {
            try await self.firebaseUseCase.insertUserEmergencyContacts(idFirestore: idFirestore, emergencyContacts: emergencyContacts)
        } catch {
            print("error while registering on vm : \(error.localizedDescription)")
        }
    }
}

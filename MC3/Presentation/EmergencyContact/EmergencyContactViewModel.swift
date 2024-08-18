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

    func fetchAllContacts() async {
        let store = CNContactStore()

        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)

        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { contact,
                    _ in
                contacts.append(contact)
            })
        } catch {
            print("Error fetcch all contact")
        }
    }

    func SaveLocalEmergencyContacts(context: ModelContext, emergencyContacts: EmergencyContacts) {
        context.insert(emergencyContacts)
    }

    func fetchLocalEmergencyContacts(context: ModelContext) -> EmergencyContacts? {
        let fetchDescriptor = FetchDescriptor<EmergencyContacts>()

        do {
            let results = try context.fetch(fetchDescriptor)
            if !results.isEmpty {
                return results[0]
            } else {
                print("Exercise not found")
            }
        } catch {
            print("Fetch error: \(error.localizedDescription)")
        }

        return nil
    }
}

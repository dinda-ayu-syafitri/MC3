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
    @Published var selectedContact: CNContact?
    @Published var isPrimary = false
    @Published var isShowingPicker = false
    @Published var emergencyContacts: [EmergencyContact] = []
    @Published var tempEmergencyContact: EmergencyContact?

    private var firebaseUseCase: FirebaseServiceUseCaseProtocol

    init(firebaseUseCase: FirebaseServiceUseCaseProtocol) {
        self.firebaseUseCase = firebaseUseCase
    }

    func fetchAllContacts() async {
        let store = CNContactStore()

        let keys = [CNContactGivenNameKey, CNContactPhoneNumbersKey] as [CNKeyDescriptor]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)

        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, _ in
                if !contact.phoneNumbers.isEmpty {
                    print("not empty")
                    self.contacts.append(contact)
                }
            })
        } catch {
            print("Error fetcch all contact")
        }
    }

    func getLocalEmergencyContacts(context: ModelContext) -> [EmergencyContact] {
        let fetchDescriptor = FetchDescriptor<EmergencyContacts>()

        let datas: [EmergencyContacts]?
        print("masuk sono")

        do {
            datas = try context.fetch(fetchDescriptor)
//            if let halos = datas {
//                for halo in halos {
//                    for hai in halo.emergencyContacts {
//                        print("data: \(hai.fullName)")
//                        print("fcm: \(String(describing: hai.fcm))")
//                    }
//                }
//            }
            return datas?.first?.emergencyContacts ?? []

        } catch {
            print("Failed to fetch emergency contacts: \(error)")
            return []
        }
//        let fetchDescriptor = FetchDescriptor<EmergencyContacts>()
//
//        do {
//            // Fetch the EmergencyContacts from the context
//            let datas = try context.fetch(fetchDescriptor)
//
//            // If datas is not empty, return the emergency contacts
//            if let halos = datas.first {
//                for hai in halos.emergencyContacts {
//                    print("data: \(hai.fullName)")
//                    print("fcm: \(String(describing: hai.fcm))")
//                }
//                return halos.emergencyContacts
//            } else {
//                // Return an empty array if no data is found
//                return []
//            }
//        } catch {
//            // Handle any errors during fetching
//            print("Failed to fetch emergency contacts: \(error)")
//            return []
//        }
    }

    func SaveLocalEmergencyContacts(context: ModelContext, emergencyContacts: [EmergencyContact]) {
        let formattedEmergencyContacts = EmergencyContacts(emergencyContacts: emergencyContacts)
        context.insert(formattedEmergencyContacts)

        for contact in emergencyContacts {
            print("name: \(contact.fullName)")
        }

        let fetchDescriptor = FetchDescriptor<EmergencyContacts>()

        let datas: [EmergencyContacts]?
        print("masuk sono")

        do {
            datas = try context.fetch(fetchDescriptor)
            if let halos = datas {
                for halo in halos {
                    for hai in halo.emergencyContacts {
                        print("data: \(hai.fullName)")
                        print("fcm: \(String(describing: hai.fcm))")
                    }
                }
            }
        } catch {
            print("Failed to fetch emergency contacts: \(error)")
        }

//        self.getLocalEmergencyContacts(context: context)
    }

    func insertUserEmergencyContacts(idFirestore: String, emergencyContacts: [EmergencyContact]) async {
        do {
            try await self.firebaseUseCase.insertUserEmergencyContacts(idFirestore: idFirestore, emergencyContacts: emergencyContacts)
        } catch {
            print("error while registering on vm : \(error.localizedDescription)")
        }
    }
}

//
//  ContactPickerView.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 15/08/24.
//

import ContactsUI
import SwiftUI

struct ContactPickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedContact: CNContact?
    @Binding var emergencyContacts: [EmergencyContact]
    @Binding var tempEmergencyContact: EmergencyContact?
    @Binding var isPrimary: Bool

    func makeUIViewController(context: Context) -> UINavigationController {
        let navController = UINavigationController()
        let controller = CNContactPickerViewController()
        controller.delegate = context.coordinator
        navController.present(controller, animated: false, completion: nil)
        return navController
    }

    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {}

    // MARK: ViewController Representable delegate methods

    func makeCoordinator() -> ContactsCoordinator {
        return ContactsCoordinator(self)
    }

    class ContactsCoordinator: NSObject, UINavigationControllerDelegate, CNContactPickerDelegate {
        let parent: ContactPickerView
        public init(_ parent: ContactPickerView) {
            self.parent = parent
        }

        func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }

        func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
            parent.presentationMode.wrappedValue.dismiss()

            // Create a new emergency contact with the correct isPrimary flag
            let newEmergencyContact = EmergencyContact(
                fullName: "\(contact.givenName)",
                phoneNumber: contact.phoneNumbers.first?.value.stringValue ?? "",
                isPrimary: parent.isPrimary
            )

            // Check if the selected contact is to be the primary contact
            if parent.isPrimary {
                // Replace any existing primary contact
                if let index = parent.emergencyContacts.firstIndex(where: { $0.isPrimary }) {
                    parent.emergencyContacts[index] = newEmergencyContact
                } else {
                    parent.emergencyContacts.append(newEmergencyContact)
                }
            } else {
                // Add new non-primary contact
                parent.emergencyContacts.append(newEmergencyContact)
            }

            parent.selectedContact = contact
            parent.tempEmergencyContact = newEmergencyContact

//            print(parent.emergencyContacts)
        }
    }
}

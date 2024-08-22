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

    private let firebaseService = FirebaseServiceDataSource()

    func makeUIViewController(context: Context) -> UINavigationController {
        let navController = UINavigationController()
        let controller = CNContactPickerViewController()
        controller.delegate = context.coordinator

        // Filter to only show contacts with at least one phone number
        controller.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0")

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

            let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
            let fullName = "\(contact.givenName)"

            Task {
                do {
                    let fcm = try await parent.firebaseService.fetchFCMKey(for: phoneNumber)

                    // Create a new emergency contact with the correct isPrimary flag and FCM key
                    let newEmergencyContact = EmergencyContact(
                        fullName: fullName,
                        phoneNumber: phoneNumber,
                        fcm: fcm,
                        isPrimary: parent.isPrimary
                    )

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
                    print(parent.emergencyContacts)

                } catch {
                    print("Error fetching FCM key: \(error.localizedDescription)")
                }
            }
        }
    }
}

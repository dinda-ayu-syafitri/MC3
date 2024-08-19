//
//  AddEmergencyContactView.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 15/08/24.
//

import Contacts
import SwiftUI

struct AddEmergencyContactView: View {
    @State private var selectedContact: CNContact?
    @State private var isShowingPicker = false

    var body: some View {
        VStack {
            Text("Add Emergency Contact")
            Text("Emergency contacts are notified when SOS Alert is activated. ")
            VStack(spacing: 16) {
                VStack {
                    HStack {
                        Text("Primary Contact")
                        Spacer()
                        Button(action: {}, label: {
                            Image(systemName: "plus")
                            Text("Add")
                        })
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.clear)
                        .stroke(.gray, lineWidth: 1)
                        .frame(height: 100)
                        .overlay(content: {
                            Text("Add one contact as your primary contact. Your primary contact can be called directly from the alert screen.")
                                .padding(5)
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.leading)
                        })
                }

                VStack {
                    HStack {
                        Text("Other Contacts")
                        Spacer()
                        Button(action: {}, label: {
                            Image(systemName: "plus")
                            Text("Add")
                        })
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.clear)
                        .stroke(.gray, lineWidth: 1)
                        .frame(height: 100)
                        .overlay(content: {
                            Text("Emergency notifications will be sent to all emergency contact")
                                .foregroundStyle(.gray)
                                .multilineTextAlignment(.leading)

                        })
                }
            }
            .padding(.top, 32)
            if let contact = selectedContact {
                VStack {
                    Text("Name: \(contact.givenName) \(contact.familyName)")
                    if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                        Text("Phone: \(phoneNumber)")
                    }
                }
                .padding()
            } else {
                Text("No contact selected")
                    .padding()
            }

            Button("Select Contact") {
                isShowingPicker = true
            }
            .sheet(isPresented: $isShowingPicker) {
                ContactPickerView(selectedContact: $selectedContact)
            }

            Spacer()
            Button(action: {}, label: {
                Text("Confirm Emergency Contact")
            })
        }
        .padding(16)
    }
}

#Preview {
    AddEmergencyContactView()
}

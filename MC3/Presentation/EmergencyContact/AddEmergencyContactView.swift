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
    @State private var emergencyContacts: [EmergencyContact] = []

    var body: some View {
        VStack {
            Text("Add your emergency contacts")
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            Text("Emergency contacts are notified when the SOS Alert is activated. ")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            VStack(spacing: 16) {
                VStack {
                    HStack {
                        Text("Primary Contact")
                        Spacer()

                        Button(action: {
                            isShowingPicker = true
                        }, label: {
                            Image(systemName: "plus")
                            Text("Add")
                        })
                        .sheet(isPresented: $isShowingPicker) {
                            ContactPickerView(selectedContact: $selectedContact)
                        }
                    }
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.clear)
                        .stroke(.gray, lineWidth: 1)
                        .frame(height: 100)
                        .overlay(content: {
                            if let contact = selectedContact {
                                VStack {
                                    Text("\(contact.givenName) \(contact.familyName)")
                                        .bold()
                                    if let phoneNumber = contact.phoneNumbers.first?.value.stringValue {
                                        Text("\(phoneNumber)")
                                    }
                                }
                                .padding()
                            } else {
                                Text("Add one contact as your primary contact. Your primary contact can be called directly from the alert screen.")
                                    .padding(5)
                                    .foregroundStyle(.gray)
                                    .multilineTextAlignment(.leading)
                            }

                        })
                }

                VStack {
                    HStack {
                        Text("Other Contacts")
                        Spacer()
                        Button(action: {
                            isShowingPicker = true
                        }, label: {
                            Image(systemName: "plus")
                            Text("Add")
                        })
                        .sheet(isPresented: $isShowingPicker) {
                            ContactPickerView(selectedContact: $selectedContact)
                        }
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

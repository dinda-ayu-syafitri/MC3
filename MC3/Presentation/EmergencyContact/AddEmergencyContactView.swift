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
    @State var isPrimary = false
    @State private var isShowingPicker = false
    @State private var emergencyContacts: [EmergencyContact] = []
    @State private var tempEmergencyContact: EmergencyContact?

    var body: some View {
        VStack {
            Text("Add your emergency contacts")
                .font(.title)
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .padding(.top, 20)

            Text("Emergency contacts are notified when the SOS Alert is activated. ")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            VStack(spacing: 16) {
                VStack {
                    HStack {
                        Text("Primary Contact")
                            .bold()
                        Spacer()

                        Button(action: {
                            isShowingPicker = true
                            isPrimary = true
                        }, label: {
                            Image(systemName: "plus")
                            Text("Add")
                        })
                        .disabled(emergencyContacts.first(where: { $0.isPrimary }) != nil).sheet(isPresented: $isShowingPicker) {
                            ContactPickerView(selectedContact: $selectedContact, emergencyContacts: $emergencyContacts, tempEmergencyContact: $tempEmergencyContact, isPrimary: $isPrimary)
                        }
                    }

                    if let primaryContact = emergencyContacts.first(where: { $0.isPrimary }) {
                        VStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.clear)
                                .stroke(.gray, lineWidth: 1)
                                .frame(height: 80)
                                .overlay(content: {
                                    VStack(alignment: .leading) {
                                        Text("\(primaryContact.fullName)")
                                            .bold()
                                            .multilineTextAlignment(.leading)
                                            .frame(maxWidth: .infinity, alignment: .leading)

                                        Text("\(primaryContact.phoneNumber)")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.leading)

                                })
                        }

                    } else {
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
                }

                VStack {
                    HStack {
                        Text("Other Contacts")
                            .bold()
                        Spacer()
                        Button(action: {
                            isShowingPicker = true
                            isPrimary = false
                        }, label: {
                            Image(systemName: "plus")
                            Text("Add")
                        })
                        .sheet(isPresented: $isShowingPicker, onDismiss: nil) {
                            ContactPickerView(selectedContact: $selectedContact, emergencyContacts: $emergencyContacts, tempEmergencyContact: $tempEmergencyContact, isPrimary: $isPrimary)
                        }
                    }

                    if let contact = emergencyContacts.first(where: { $0.isPrimary == false }) {
                        VStack {
                            ForEach(emergencyContacts) { contact in
                                if !contact.isPrimary {
                                    VStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(.clear)
                                            .stroke(.gray, lineWidth: 1)
                                            .frame(height: 80)
                                            .overlay(content: {
                                                VStack(alignment: .leading) {
                                                    Text("\(contact.fullName)")
                                                        .bold()
                                                        .multilineTextAlignment(.leading)
                                                        .frame(maxWidth: .infinity, alignment: .leading)

                                                    Text("\(contact.phoneNumber)")
                                                        .frame(maxWidth: .infinity, alignment: .leading)
                                                        .multilineTextAlignment(.leading)
                                                }
                                                .padding()
                                                .frame(maxWidth: .infinity)
                                                .multilineTextAlignment(.leading)

                                            })
                                    }
                                }
                            }
                        }
                    } else {
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

//
//  AddContactsView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 14/08/24.
//

import SwiftUI
import Contacts

struct AddContactsView: View {
    @State private var contacts: [Contact] = [] // Array to hold contact forms

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Add your emergency contacts")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                Text("Emergency contacts are notified when the SOS Alert is activated. Your primary contact can be called directly from the alert screen.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                ScrollView {
                    ForEach(contacts) { contact in
                        ContactFormView(contact: contact)
                            .padding(.horizontal)
                    }
                }
                
                Button(action: {
                    // Action to add new contact form
                    contacts.append(Contact(name: "", phoneNumber: ""))
                }) {
                    Text("+ Add new contact")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                
                NavigationLink(destination: HomeView()
                    .navigationBarBackButtonHidden(true)) {
                    Text("Finish adding contacts")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 8)
                
            }
            .padding()
            .background(Color(.systemGray6))
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarBackButtonHidden(true) // Hides the back button
        }
    }
}

struct ContactFormView: View {
    @State var contact: Contact // Binding to the contact
    @State private var isShowingContactPicker = false // State to manage the sheet

    var body: some View {
        VStack(spacing: 10) {
            HStack {
                TextField("ex. Jane Doe", text: $contact.name)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                
                Button(action: {
                    isShowingContactPicker.toggle() // Show the contact picker sheet
                }) {
                    Image(systemName: "person.crop.circle.fill")
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                }
//                .sheet(isPresented: $isShowingContactPicker) {
//                    ContactPickerView(selectedContact: $contact)
//                }
            }
            .cornerRadius(8)
            
            TextField("ex. 6287821285666", text: $contact.phoneNumber)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray, lineWidth: 1)
                )
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct Contact: Identifiable {
    var id = UUID()
    var name: String
    var phoneNumber: String
}

#Preview {
    AddContactsView()
}

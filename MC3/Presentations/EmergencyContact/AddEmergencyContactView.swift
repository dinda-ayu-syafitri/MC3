//
//  AddEmergencyContactView.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 15/08/24.
//

import Contacts
import FirebaseAuth
import SwiftData
import SwiftUI

struct AddEmergencyContactView: View {
    @Environment(\.modelContext) public var context

    @State private var selectedContact: CNContact?
    @State var isPrimary = false
    @State private var isShowingPicker = false
    @State private var emergencyContacts: [EmergencyContact] = []
    @State private var tempEmergencyContact: EmergencyContact?

    @Query public var emergencyContactSaved: [EmergencyContacts]

    @StateObject var emergencyContactVM = DependencyInjection.shared.emergencyContactsViewModel()

    @EnvironmentObject var router: Router
    var body: some View {
        VStack {
            Text("Add your emergency contacts")
                .font(.title2)
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .padding(.top,28)

            Text("Emergency contacts are notified when the SOS Alert is activated. ")
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            VStack(spacing: 16) {
                VStack {
                    HStack {
                        Text("Primary Contact")
                            .bold()
                        Spacer()
                        ZStack{
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(Color.appPink)
                                .frame(width: 80, height: 35)
                                
                            Button(action: {
                                isShowingPicker = true
                                isPrimary = true
                            }, label: {
                                Image(systemName: "plus")
                                Text("Add")
                            })
                            .foregroundColor(Color.bg)
                            .disabled(emergencyContacts.first(where: { $0.isPrimary }) != nil).sheet(isPresented: $isShowingPicker) {
                                ContactPickerView(selectedContact: $selectedContact, emergencyContacts: $emergencyContacts, tempEmergencyContact: $tempEmergencyContact, isPrimary: $isPrimary)
                            }
                        }
                        
                    }

                    if let primaryContact = emergencyContacts.first(where: { $0.isPrimary }) {
                        List {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.clear)
                               // .stroke(.gray, lineWidth: 1)
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
                                    
                                    .frame(maxWidth: .infinity)
                                    .multilineTextAlignment(.leading)

                                })
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        if let index = emergencyContacts.firstIndex(where: { $0.id == primaryContact.id }) {
                                            emergencyContacts.remove(at: index)
                                        }
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                        .frame(height: 100)
                        .listStyle(PlainListStyle())
                        .clipShape(RoundedRectangle(cornerRadius: 15.0))
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
                        ZStack{
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.appPink)
                                .frame(width: 80, height: 35)
                            Button(action: {
                                isShowingPicker = true
                                isPrimary = false
                            }, label: {
                                Image(systemName: "plus")
                                Text("Add")
                                    
                            })
                            .foregroundStyle(Color.white)
                            .sheet(isPresented: $isShowingPicker, onDismiss: nil) {
                                ContactPickerView(selectedContact: $selectedContact, emergencyContacts: $emergencyContacts, tempEmergencyContact: $tempEmergencyContact, isPrimary: $isPrimary)
                            }
                        }
                    }

                    if emergencyContacts.first(where: { $0.isPrimary == false }) != nil {
                        VStack {
                            List {
                                ForEach(emergencyContacts) { contact in
                                    if !contact.isPrimary {
                                        RoundedRectangle(cornerRadius: 15.0)
                                            .fill(.clear)
                                            //.stroke(.gray, lineWidth: 1)
                                            .frame(height: 80)
                                            .frame(maxWidth: .infinity)
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
                                                //.padding()

                                                .frame(maxWidth: .infinity)
                                                .multilineTextAlignment(.leading)

                                            })
                                            .padding(0)
                                            .swipeActions(edge: .trailing) {
                                                Button(role: .destructive) {
                                                    if let index = emergencyContacts.firstIndex(where: { $0.id == contact.id }) {
                                                        emergencyContacts.remove(at: index)
                                                    }
                                                } label: {
                                                    Label("Delete", systemImage: "trash")
                                                }
                                            }
                                    }
                                }
                            }
                           
                            .listStyle(PlainListStyle())
                            .clipShape(RoundedRectangle(cornerRadius: 15.0))
                            //.padding(.horizontal,-20)
                            
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
            .padding(.top, 2)
            .padding()

//            if !emergencyContactSaved.isEmpty {
//                ForEach(emergencyContactSaved.first!.emergencyContacts, id: \.id) { contact in
//                    VStack {
//                        Text(contact.fullName)
//                        Text("\(emergencyContactSaved.first?.emergencyContacts.count)")
//                    }
//                }
//            } else {
//                Text("Emergency Contact Empty")
//            }


            Spacer()
            Button(action: {
                Task {
                    let firebaseID = Auth.auth().currentUser?.uid
                    await emergencyContactVM.insertUserEmergencyContacts(idFirestore: firebaseID ?? "", emergencyContacts: emergencyContacts)

                    emergencyContactVM.SaveLocalEmergencyContacts(context: context, emergencyContacts: emergencyContacts)
                }
            }, label: {
                ZStack{
                    RoundedRectangle(cornerRadius: 15.0)
                        .fill(Color.appPink)
                        .frame(width: 360, height: 60)
                    Text("Confirm Emergency Contact")
                        .foregroundStyle(Color.white)
                }
                .onTapGesture {
                    router.navigateTo(.HomeView)
                }
                
            })
            .padding()

//            Button(action: {
//                Task {
//                    for contact in emergencyContactSaved {
//                        context.delete(contact)
//                    }
//
//                    do {
//                        try context.save()
//                    } catch {
//                        print("Failed to delete contacts: \(error.localizedDescription)")
//                    }
//                }
//            }, label: {
//                Text("Delete All Local Contacts")
//            })

        }
        .background(Color.bg)
    }
}

#Preview {
    AddEmergencyContactView()
}

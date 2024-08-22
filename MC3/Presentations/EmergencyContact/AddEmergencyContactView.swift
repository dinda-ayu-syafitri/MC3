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
    @Query public var emergencyContactSaved: [EmergencyContacts]
    @StateObject var emergencyContactVM = DependencyInjection.shared.emergencyContactsViewModel()
    @StateObject var messageVM = DependencyInjection.shared.MessageNotifViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Text("Add your emergency contacts")
                .font(.title2)
                .multilineTextAlignment(.center)
                .fontWeight(.bold)
                .foregroundStyle(.blackBrand)
                .padding(.top,28)
            Text("Emergency contacts are notified when the SOS Alert is activated. ")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .foregroundStyle(.blackBrand)
            
            VStack(spacing: 16) {
                VStack {
                    HStack {
                        Text("Primary Contact")
                            .bold()
                            .foregroundStyle(.blackBrand)
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 25.0)
                                .fill(emergencyContactVM.emergencyContacts.first(where: { $0.isPrimary }) != nil ? .gray : Color.appPink)
                                .frame(width: 80, height: 35)
             Button(action: {
                                emergencyContactVM.isShowingPicker = true
                                emergencyContactVM.isPrimary = true
                            }, label: {
                                Image(systemName: "plus")
                                Text("Add")
                            })
                            .foregroundColor(emergencyContactVM.emergencyContacts.first(where: { $0.isPrimary }) != nil ? .black : Color.bg)
                            .disabled(emergencyContactVM.emergencyContacts.first(where: { $0.isPrimary }) != nil)
                            .sheet(isPresented: $emergencyContactVM.isShowingPicker) {
                                ContactPickerView(
                                    selectedContact: $emergencyContactVM.selectedContact,
                                    emergencyContacts: $emergencyContactVM.emergencyContacts,
                                    tempEmergencyContact: $emergencyContactVM.tempEmergencyContact,
                                    isPrimary: $emergencyContactVM.isPrimary
                                )
                            }
                        }
                    }
                    
                    if let primaryContact = emergencyContactVM.emergencyContacts.first(where: { $0.isPrimary }) {
                        List {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.clear)
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
                                        if let index = emergencyContactVM.emergencyContacts.firstIndex(where: { $0.id == primaryContact.id }) {
                                            emergencyContactVM.emergencyContacts.remove(at: index)
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
                            .foregroundStyle(.blackBrand)
                        Spacer()
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.appPink)
                                .frame(width: 80, height: 35)
                            Button(action: {
                                emergencyContactVM.isShowingPicker = true
                                emergencyContactVM.isPrimary = false
                            }, label: {
                                Image(systemName: "plus")
                                Text("Add")
                            })
                            .foregroundStyle(Color.white)
                            .sheet(isPresented: $emergencyContactVM.isShowingPicker, onDismiss: nil) {
                                ContactPickerView(selectedContact: $emergencyContactVM.selectedContact, emergencyContacts: $emergencyContactVM.emergencyContacts, tempEmergencyContact: $emergencyContactVM.tempEmergencyContact, isPrimary: $emergencyContactVM.isPrimary)
                            }
                        }
                    }
                    
                    if emergencyContactVM.emergencyContacts.first(where: { $0.isPrimary == false }) != nil {
                        VStack {
                            List {
                                ForEach(emergencyContactVM.emergencyContacts) { contact in
                                    if !contact.isPrimary {
                                        RoundedRectangle(cornerRadius: 15.0)
                                            .fill(.clear)
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
                                                .frame(maxWidth: .infinity)
                                                .multilineTextAlignment(.leading)
                                                
                                            })
                                            .padding(0)
                                            .swipeActions(edge: .trailing) {
                                                Button(role: .destructive) {
                                                    if let index = emergencyContactVM.emergencyContacts.firstIndex(where: { $0.id == contact.id }) {
                                                        emergencyContactVM.emergencyContacts.remove(at: index)
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
                            // .padding(.horizontal,-20)
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
            Spacer()
            
            //Testing Send Data Emergency Contact
            Button{
                print("Button Pressed")

                iOSToWatchConnector.shared.sendPrimaryContact(name: "Papa", phone: "081388910174")
            } label: {
                Text("send primary contact")
            }
            
            Button(action: {
                Task {
                    let firebaseID = Auth.auth().currentUser?.uid
                    await emergencyContactVM.insertUserEmergencyContacts(idFirestore: firebaseID ?? "", emergencyContacts: emergencyContactVM.emergencyContacts)
                    
                    emergencyContactVM.SaveLocalEmergencyContacts(context: context, emergencyContacts: emergencyContactVM.emergencyContacts)
                }
                
            }, label: {
                ZStack {
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
        }
        .background(Color.bg)
    }
}

#Preview {
    AddEmergencyContactView()
}

//
//  ProfileView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 15/08/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var profileVM = ProfileViewModel()
    
    var body: some View {
        NavigationView { // Add this line
            ScrollView{
                VStack {
                    // Profile Header
                    VStack(spacing: 10) {
                        Text("Settings")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.appPinkSecondary)
                        
                        Circle()
                            .fill(Color.appPinkSecondary)
                            .frame(width: 80, height: 80)
                        
                        Text("Syafiqah A")
                            .font(.headline)
                        
                        Text("6287821285607")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    .padding(.top)
                    
                    // Contacts Section
                    SectionHeader(title: "Contacts")
                    
                    NavigationLink(destination: AddEmergencyContactView()) {
                        ProfileRow(title: "Emergency Contacts")
                    }
                    
                    // Security Section
                    SectionHeader(title: "Security")
                    
                    NavigationLink(destination: Text("Pin Input View")) {
                        ProfileRow(title: "Personal Pin")
                    }
                    
                    // Settings Section
                    SectionHeader(title: "Settings")
                    
                    // SOS Alert Delay Time with Picker
                    Button(action: {
                        withAnimation {
                            profileVM.isPickerExpanded.toggle()
                        }
                    }) {
                        HStack {
                            Text("SOS Alert Delay Time")
                                .foregroundColor(.black)
                            Spacer()
                            Text("\(profileVM.selectedDelayTime) seconds")
                                .foregroundColor(.gray)
                            Image(systemName: "chevron.right")
                                .rotationEffect(.degrees(profileVM.isPickerExpanded ? 90 : 0))
                                .animation(.easeInOut, value: profileVM.isPickerExpanded)
                                .foregroundStyle(Color.appPinkSecondary)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    }
                    
                    if profileVM.isPickerExpanded {
                        Picker("Select Delay Time", selection: $profileVM.selectedDelayTime) {
                            ForEach(profileVM.delayTimes, id: \.self) { time in
                                Text("\(time) seconds").tag(time)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 150)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .transition(.move(edge: .bottom))
                    }
                    
                    Toggle(isOn: $profileVM.enableAlertSound) {
                        Text("Enable Alert Sound")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    Toggle(isOn: $profileVM.enableHaptic) {
                        Text("Enable haptic")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    Toggle(isOn: $profileVM.enableAutomaticAlert) {
                        Text("Enable automatic alert")
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
                    
                    Button(action: {
                        profileVM.logOut()
                    }, label: {
                        Text("Log out")
                            .foregroundStyle(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(10)
                            .padding(.horizontal)
                    })
                    
                    Spacer()
                }
            }
            .background(Color(.bg).ignoresSafeArea())
        } 
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top, 20)
    }
}

struct ProfileRow: View {
    let title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.black)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.appPinkSecondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)

    }
}

#Preview {
    ProfileView()
}

//
//  ProfileView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 15/08/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var enableAlertSound = true
    @State private var enableHaptic = true
    @State private var enableAutomaticAlert = true
    @State private var isPickerExpanded = false
    @State private var selectedDelayTime = 5
    let delayTimes = Array(1...10) // Range from 1 to 10 seconds
    
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
                            .frame(width: 120, height: 120)
                        
                        Text("Syafiqah A")
                            .font(.title2)
                            .bold()
                        
                        Text("6287821285607")
                            .font(.callout)
                            .foregroundColor(.black)
                    }
                    .padding(.top)
                    
                    // Contacts Section
                    Section(header: Text("Contacts")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .frame(maxWidth: .infinity, alignment: .leading)){
                            NavigationLink(destination: AddEmergencyContactView()) {
                                ProfileRow(title: "Emergency Contacts")
                            }
                    }
                       
                    Section(header: Text("Security")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .leading)){
                            NavigationLink(destination: Text("Pin Input View")) {
                                ProfileRow(title: "Personal Pin")
                            }
                    }
                        
                    
                    Section(header: Text("Settings")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top)
                        .frame(maxWidth: .infinity, alignment: .leading)){
                            // SOS Alert Delay Time with Picker
                            Button(action: {
                                withAnimation {
                                    isPickerExpanded.toggle()
                                }
                            }) {
                                HStack {
                                    Text("SOS Alert Delay Time")
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text("\(selectedDelayTime) seconds")
                                        .foregroundColor(.gray)
                                    Image(systemName: "chevron.right")
                                        .rotationEffect(.degrees(isPickerExpanded ? 90 : 0))
                                        .animation(.easeInOut, value: isPickerExpanded)
                                        .foregroundStyle(Color.appPinkSecondary)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                            //.padding(.vertical, -5)
                            
                            if isPickerExpanded {
                                Picker("Select Delay Time", selection: $selectedDelayTime) {
                                    ForEach(delayTimes, id: \.self) { time in
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
                            
                            
                            Toggle(isOn: $enableHaptic) {
                                Text("Enable haptic")
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.vertical, -5)
                            
                            Toggle(isOn: $enableAutomaticAlert) {
                                Text("Enable automatic alert")
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            
                            Spacer()
                        }
                    }
                    
                    
                    
            }
            .background(Color(.bg).ignoresSafeArea())
        } // Close NavigationView here
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

//
//  ProfileView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 14/08/24.
//


import SwiftUI

struct ProfileView: View {
    @State private var isAutomaticAlertActivated = true
    @State private var selectedDelayTime = 5
    @State private var isShowingDelayPicker = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 40) // To push the content down a bit
                
                // Profile Picture and Name
                VStack {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 100, height: 100)
                    
                    Text("Syafiqah A")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 8)
                    
                    Text("6287821285607")
                        .font(.body)
                        .foregroundColor(.gray)
                }
                
                Spacer().frame(height: 40) // Spacer for vertical spacing
                
                // Contacts Section
                List {
                    Section(header: Text("Contacts")) {
                        NavigationLink(destination: Text("Emergency Contacts")) {
                            HStack {
                                Text("Emergency Contacts")
                                Spacer()
                               
                            }
                        }
                        
                        NavigationLink(destination: Text("Emergency Contactee")) {
                            HStack {
                                Text("Emergency Contactee (?)")
                                Spacer()
                                
                            }
                        }
                    }
                    
                    // Security Section
                    Section(header: Text("Security")) {
                        NavigationLink(destination: Text("Personal Pin")) {
                            HStack {
                                Text("Personal Pin")
                                Spacer()
                                
                            }
                        }
                    }
                    
                    // Settings Section
                    Section(header: Text("Settings")) {
                        Button(action: {
                            isShowingDelayPicker = true
                        }) {
                            HStack {
                                Text("SOS Alert Delay Time")
                                Spacer()
                                Text("\(selectedDelayTime) seconds")
                                    .foregroundColor(.gray)
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $isShowingDelayPicker) {
                            DelayTimePickerView(selectedDelayTime: $selectedDelayTime)
                        }
                        
                        Toggle(isOn: $isAutomaticAlertActivated) {
                            Text("Activate automatic alert")
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle()) // List style to match the design
                
                Spacer()
                
            }
          
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
        }
    }
}

struct DelayTimePickerView: View {
    @Binding var selectedDelayTime: Int
    let delayTimes = Array(1...60) // Array of delay times from 1 to 60 seconds

    var body: some View {
        VStack {
            Picker(selection: $selectedDelayTime, label: Text("Select Delay Time")) {
                ForEach(delayTimes, id: \.self) { time in
                    Text("\(time) seconds")
                        .tag(time)
                }
            }
            .pickerStyle(WheelPickerStyle())
            .frame(height: 150)
            .clipped()
            
            Spacer()
            
            Button(action: {
                // Action to dismiss the picker, if needed
            }) {
                Text("Done")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
    }
}

#Preview {
    ProfileView()
}

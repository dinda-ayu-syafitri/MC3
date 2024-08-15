//
//  ProfileView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 15/08/24.
//

import SwiftUI

struct ProfileView: View {
    @State private var enableHaptic = true
    @State private var enableAutomaticAlert = true
    
    var body: some View {
        ScrollView{
            VStack {
                // Profile Header
                VStack(spacing: 10) {
                    Text("Profile")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Circle()
                        .fill(Color.gray)
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
                
                NavigationLink(destination: Text("Emergency Contacts Page")) {
                    ProfileRow(title: "Emergency Contacts")
                }
                
                // Security Section
                SectionHeader(title: "Security")
                
                NavigationLink(destination: Text("Personal Pin Page")) {
                    ProfileRow(title: "Personal Pin")
                }
                
                // Settings Section
                SectionHeader(title: "Settings")
                
                HStack {
                    Text("SOS Alert Delay Time")
                        .foregroundColor(.black)
                    Spacer()
                    Text("5 seconds")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Toggle(isOn: $enableHaptic) {
                    Text("Enable haptic")
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                Toggle(isOn: $enableAutomaticAlert) {
                    Text("Enable automatic alert")
                        .foregroundColor(.black)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .padding(.horizontal)
                
                // Buttons Section
                Button(action: {
                    // Action for setting up Back Tap
                }) {
                    Text("Set up Back Tap")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(20)
                }
                .padding(.top)
                .padding(.horizontal)
                
                Button(action: {
                    // Action for setting up Watch Complications
                }) {
                    Text("Set up Watch Complications")
                        .font(.headline)
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(20)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            
        }
        .background(Color(.systemGray6).ignoresSafeArea())
        
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
                .foregroundColor(.gray)
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

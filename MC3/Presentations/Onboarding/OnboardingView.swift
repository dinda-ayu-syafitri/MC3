//
//  OnboardingView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 14/08/24.
//

import SwiftUI

struct OnboardingView: View {
    @State private var selectedTab = 0
    @EnvironmentObject var router: Router

    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selectedTab) {
                    FirstScreenView(selectedTab: $selectedTab)
                        .tag(0)
                    SecondScreenView()
                        .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .padding(.bottom, 50)

                Spacer()

                if selectedTab < 1 {
                    Button(action: {
                        selectedTab += 1
                    }) {
                        Text("Next")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.gray.opacity(0.5))
                            .cornerRadius(30)
                            .padding(.horizontal)
                    }
                } else {
//                    NavigationLink(destination: PermissionView()
//                                    .navigationBarBackButtonHidden(true)) {
                    Text("Get Started")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.5))
                        .cornerRadius(30)
                        .padding(.horizontal)
                        .onTapGesture {
                            router.navigateTo(.AddEmergencyContact)
                        }
//                    }
                }
            }
            .padding(.bottom, 30)
            .edgesIgnoringSafeArea(.bottom)
            .background(Color(.systemGray6))
            .navigationBarHidden(true)
        }
    }
}

struct FirstScreenView: View {
    @Binding var selectedTab: Int

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Quicker access with Watch")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                Text("This application is best used as a companion app for Apple Watch. Use watch to provide easier access to SOS alert when in danger.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 350)
                    .cornerRadius(10)

                Spacer()
            }
            .padding()
        }
    }
}

struct SecondScreenView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text("Backup with Back Tap")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                Text("Set up Back Tap to activate the SOS alert by tapping the back of your phone. You can add custom shortcuts through the Shortcuts app.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 350)
                    .cornerRadius(10)

                Spacer()
            }
            .padding()
        }
    }
}

struct PermissionView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                // Title
                Text("Allow us to stay by your side")
                    .font(.headline)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Subtitle
                Text("By monitoring your heart rate through Apple Watch, our app quickly responds to sudden spikes, automatically activating the SOS alert.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .padding(.top, 8)

                Spacer()

                // Image placeholder
                Rectangle()
                    .foregroundColor(Color.gray.opacity(0.3))
                    .frame(height: 300)
                    .cornerRadius(10)
                    .padding(.horizontal)

                Spacer()

                // Permission button
                NavigationLink(destination: AddContactsView().navigationBarHidden(true)) {
                    Text("Give permission")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray)
                        .cornerRadius(30)
                }
                .padding(.horizontal)
                .padding(.bottom, 8)

                // Skip button
                NavigationLink(destination: AddContactsView().navigationBarHidden(true)) {
                    Text("Skip for now")
                        .foregroundColor(.black)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .overlay(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .padding(.top, 40)
            .background(Color(UIColor.systemGray6))
            .edgesIgnoringSafeArea(.all)
            .navigationBarHidden(true) // Hide the navigation bar on the current screen
        }
    }
}

#Preview {
    OnboardingView()
}

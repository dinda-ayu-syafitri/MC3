//
//  HomepageView.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 11/08/24.
//

import SwiftUI

struct HomepageView: View {
    @StateObject private var homepageVM = HomepageViewModel()
    @State private var isPublisher = false
    @State private var isListener = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("Welcome, \(homepageVM.userName)")
                    .font(.title)
                    .padding(.bottom, 5)
                
                Text("Email: \(homepageVM.userEmail)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                Spacer()
                
                // Button to navigate to publisher view
                VStack {
                    Button {
                        isPublisher = true
                    } label: {
                        Text("Become Publisher")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(width: 300)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 32)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.black, Color.gray]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                    .navigationDestination(
                        isPresented: $isPublisher) {
                            PublisherView()
                        }
                }
                
                // Button to navigate to listener view
                VStack {
                    Button {
                        isListener = true
                    } label: {
                        Text("Become Listener")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(width: 300)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 32)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.black, Color.gray]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                    }
                    .navigationDestination(
                        isPresented: $isListener) {
                            ListenerView()
                        }
                }
                
                Button(action: {
                    homepageVM.logOut()
                    print("Logged Out")
                }, label: {
                    Text("Log Out")
                        .font(.headline)
                        .fontWeight(.bold)
                        .frame(width: 300)
                        .padding(.vertical, 14)
                        .padding(.horizontal, 32)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.black, Color.gray]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .foregroundColor(.white)
                        .clipShape(Capsule())
                        .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                })
            }
        }
    }
}

#Preview {
    HomepageView()
}

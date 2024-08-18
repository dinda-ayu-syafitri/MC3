//
//  HomeView.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 13/08/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var healthKitManager = HealthKitManager()
    @StateObject private var heartRateViewModel = HeartRateViewModel()
    @StateObject var watchToiOSConnector = WatchToiOSConnector()
    
    @State var isCountdownViewPresented: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // SOS State
            HStack {
                Text("SOS Inactive")
                    .onTapGesture {
                        isCountdownViewPresented = true
                    }
                    .font(.system(size: 17) .weight(.semibold))
                    .foregroundColor(.pastelPink)
                    .frame(alignment: .leading)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            
            // SOS button
            Button(action: {
                watchToiOSConnector.sendTriggerToiOS()
            }) {
                
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 8) {
                    Image(systemName: "bell.and.waves.left.and.right.fill")
                        .font(
                            .system(size: 34)
                                .weight(.bold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.white)

                        .frame(maxWidth: .infinity, alignment: .top)
                    
                    Text("Activate\nSOS Alert")
                        .font(.system(size: 17) .weight(.semibold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .top)
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                .padding(.horizontal, 8)
//                .padding(.vertical, 14)
                .background(LinearGradient(
                    gradient: Gradient(colors: [Color(.melonPink), Color(.darkPink)]),
                    startPoint: .top,
                    endPoint: .bottom
                ))
                .cornerRadius(12)
                
                
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea()
        .fullScreenCover(isPresented: $isCountdownViewPresented, content: {
//            CountdownView()
//            CallView()
            DeactivateView()
        })
        .navigationTitle("Home")
        
    }
}

#Preview {
    HomeView()
}

// BPM text
//            HStack(spacing: 7) {
//
//                Text(heartRateViewModel.heartRateModel.heartRate == 0 ? "--" : "\(Int(heartRateViewModel.heartRateModel.heartRate))")
//                    .font(.largeTitle)
//
//                HStack(spacing: 1) {
//                    Text("BPM")
//                        .font(.headline)
//                    Image(systemName: "heart.fill")
//                        .foregroundColor(.red)
//                        .frame(width: 24, height: 22)
//                }
//            }

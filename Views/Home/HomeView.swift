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
    
    var body: some View {
        VStack(spacing: 0) {
            
            Toggle(isOn: $heartRateViewModel.isEnableBackgroundDelivery, label: {
                Text("Background tracking")
            })
            .padding()
            
            Spacer()
            
            HStack(spacing: heartRateViewModel.heartRateModel.heartRate == 0 ? 0 : 7) {
                
                Text(heartRateViewModel.heartRateModel.heartRate == 0 ? "--" : "\(Int(heartRateViewModel.heartRateModel.heartRate))")
                //                    .font(.system(size: 33))
                //                    .fontWeight(.medium)
                //                    .frame(width: heartRateViewModel.heartRateModel.heartRate == 0 ? 25 : 50, height: 22)
                
                HStack(spacing: 1) {
                    // Display the text "BPM".
                    Text("BPM")
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .frame(width: 24, height: 22)
                    
                }
            }
            
            Spacer()
            
            
            //SOS button
            Button {
                heartRateViewModel.sendSOSAlert = true
                
            } label: {
                Circle()
                    .overlay(
                        Text("SOS")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    )
            }
            .buttonStyle(PlainButtonStyle())
            
            
            
            Spacer()
        }
        .sheet(isPresented: $heartRateViewModel.isSOSCountdownActive ) {
            Text("setting automatic alert page") //isPresentednya blm diganti jg
        }
        .onAppear {
            // start the heart rate query (salah satu aja bg/foreground)
            if heartRateViewModel.isEnableBackgroundDelivery == false {
                heartRateViewModel.fetchHeartRateDataForeground()
            }
        }
        
    }
}

#Preview {
    HomeView()
}

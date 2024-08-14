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
    
    var body: some View {
        VStack() {
            
            Toggle(isOn: $heartRateViewModel.isEnableBackgroundDelivery, label: {
                Text("Background tracking")
            })
            .padding()
            
            
            //BPM text
            HStack(spacing: heartRateViewModel.heartRateModel.heartRate == 0 ? 0 : 7) {
                
                Text(heartRateViewModel.heartRateModel.heartRate == 0 ? "--" : "\(Int(heartRateViewModel.heartRateModel.heartRate))")
                
                HStack(spacing: 1) {
                    // Display the text "BPM".
                    Text("BPM")
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .frame(width: 24, height: 22)
                }
            }
            
            
            //SOS button
            Button {
                //                heartRateViewModel.sendSOSAlert = true
                watchToiOSConnector.sendTriggerToiOS()
                
            } label: {
                Circle()
                    .foregroundColor(.pink)
                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Text("SOS")
                            .fontWeight(.bold)
                            .foregroundColor(.primary)
                    )
            }
            .buttonStyle(PlainButtonStyle())
            
        }
        .padding()
        .ignoresSafeArea()
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

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
                Text("Automatic alert")
                    .font(.headline)
            }).padding()
            
            /// Heart Rate BPM
            HStack(spacing: 7) {
                Text(heartRateViewModel.heartRateModel.heartRate == 0 ? "--" : "\(Int(heartRateViewModel.heartRateModel.heartRate))")
                    .font(.largeTitle)
                
                HStack(spacing: 1) {
                    Text("BPM")
                        .font(.headline)
                    Image(systemName: "heart.fill")
                        .foregroundColor(.red)
                        .frame(width: 24, height: 22)
                }
            }
            
            /// SOS button
            Button(action: {
                heartRateViewModel.createNotification(notificationType: .SOSALERT)
            }) {
                RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                    .foregroundColor(.pink)
                    .frame(width: 120, height: 120)
                    .overlay(
                        Text("Activate SOS Alert")
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                    )
            }
            .buttonStyle(PlainButtonStyle())
        }
        .onAppear{
//            heartRateViewModel.popUpNotif()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                watchToiOSConnector.sendTriggerToiOS()
                heartRateViewModel.createNotification(notificationType: .ABNORMALHEARTRATE)
                print("HomeView Appear")
               }
//            NotificationManager.shared.scheduleNotification(
//            title: "High Heart Rate",
//            body: "test",
//            category: "SOS_Category"
//        )
//            print("HomeView Appear")
        }
        .padding()
        .navigationTitle("Home")
    }
}

#Preview {
    HomeView()
}

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
                watchToiOSConnector.sendTriggerToiOS(notificationType: .SOSALERT)
            }) {
                
                VStack(alignment: .center, spacing: 8) {
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
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                heartRateViewModel.createNotificatiown(notificationType: .ABNORMALHEARTRATE)
            }

        }
        
    }
}

#Preview {
    HomeView()
}

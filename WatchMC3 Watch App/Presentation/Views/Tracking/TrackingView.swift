//
//  TrackingView.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 18/08/24.
//

import SwiftUI

struct TrackingView: View {
    var route = RouterWatch.shared
    @StateObject var trackingVM = TrackingViewModel.shared
    @Environment(\.openURL) var openURL
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
                // SOS State
                HStack {
                    Text("SOS Active")
                        .font(.system(size: 17) .weight(.semibold))
                        .foregroundColor(.pastelPink)
                        .frame(alignment: .leading)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                
            ScrollView {
                VStack(spacing: 10) {
                    //Tracking Status
                    VStack(spacing: 8) {
                        //Heading
                        Text("SOS Alert\nhas been sent!")
                            .font(
                                .system(size: 17)
                                .weight(.semibold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .top)
                        
//                        // Subtitle
//                        Text("Your emergency contacts has been notified.")
//                            .font(.system(size: 16))
//                            .multilineTextAlignment(.center)
//                            .foregroundColor(.barbiePink)
//                            .frame(maxWidth: .infinity, alignment: .top)
                    }
                    .padding(.top, 8)
                    .padding(.bottom, 8)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                   
                    //Call Emergency Contact Alert
                    Button(action: {
                        trackingVM.callEmergencyContact(openURL: openURL)
                    }) {
                        Text("Call \(trackingVM.emergencyContact.fullName)")
                            .font(.system(size: 13).weight(.semibold))
                            .frame(maxWidth: .infinity, maxHeight: 28)
                            .padding(.vertical, 14)
                            .padding(.horizontal, 10)
                            .background(.melonPink)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .buttonStyle(.plain)
                    
                    //Deactivate SOS button
                    Button(action: {
                        route.navigateTo(.deactivateView)
                    }) {
                        Text("Deactivate alert")
                            .font(.system(size: 13).weight(.semibold))
                            .frame(maxWidth: .infinity, maxHeight: 28)
                            .padding(10)
                            .background(Color.red.opacity(0.5))
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    .buttonStyle(.plain)
                }
                
            }
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .ignoresSafeArea()
        .background(.black)
        .navigationBarBackButtonHidden()

        
    }
}

#Preview {
    TrackingView()
}

//
//  ContentView.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 09/08/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @StateObject var watchConnector = iOSToWatchConnector()
    @EnvironmentObject var router: Router
    @AppStorage(KeyUserDefaultEnum.statusBoarding.toString) private var logStatus: Int = 0
    @Query private var emergencyContactSaved: [EmergencyContacts]
    
    var body: some View {
        RouterView {
            ZStack {
                switch logStatus {
                case 0:
                    OnboardingViewWrapper()
                case 1:
                    LoginView()
                case 2:
                    ProfileSetUpView()
                case 3:
                    AddEmergencyContactView(fromSetting: false)
                case 4:
                    PersonalPinView()
                case 5:
                    HomeView(selectedTab: .liveTrack)
                default:
                    HomeView(selectedTab: .sos)
                }
            }
        }
        .onAppear {
            watchConnector.emergencyContactSaved = emergencyContactSaved
        }
    }
}

#Preview {
    ContentView()
}

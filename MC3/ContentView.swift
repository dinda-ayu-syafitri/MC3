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
    @Query private var emergencyContactSaved: [EmergencyContacts]


    @AppStorage(KeyUserDefaultEnum.status.toString) private var logStatus: Bool = false
    
    var body: some View {
        RouterView {
            ZStack {
                if logStatus {
                    OnboardingView()
//                               ProfileSetUpView()

//                    PersonalPinView()
//                    HomeView()
//                CountdownView()
                } else {
                    LoginView()
                }
            }
            .padding()
        }
        .onAppear {
            watchConnector.emergencyContactSaved = emergencyContactSaved
        }
    }
}

#Preview {
    ContentView()
}

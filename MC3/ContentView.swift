//
//  ContentView.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 09/08/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var watchConnector = iOSToWatchConnector()
    @AppStorage(KeyUserDefaultEnum.status.toString) private var logStatus: Bool = false
    
    var body: some View {
        ZStack {
//                        if logStatus {
//                            HomeView()
//            //            CountdownView()
            PersonalPinView()
//                        } else {
//            LoginView()
//                        }
        }
    }
}

#Preview {
    ContentView()
}

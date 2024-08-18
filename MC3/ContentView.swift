//
//  ContentView.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 09/08/24.
//

import SwiftUI

struct ContentView: View {
//     @State var reachable = "No"
//     @StateObject var watchConnector = iOSToWatchConnector()
    
//     var body: some View {
//         VStack {
//             Spacer()
            
//             if watchConnector.messageText == "sosAlert" {
//                 Text(watchConnector.messageText)
//             }
            
            
//             Spacer()
            
//             Text("Reachable \(reachable)")
            
//             Button(action: {
//                 if watchConnector.session.isReachable{
//                     self.reachable = "Yes"
//                 }
//                 else{
//                     self.reachable = "No"
//                 }
                
//             }) {
//                 Text("Update")
//             }
            
//             Spacer()
            
            //            Image(systemName: "globe")
            //                .imageScale(.large)
            //                .foregroundStyle(.tint)
            //            Text("Hello, world!")
    @AppStorage(KeyUserDefaultEnum.status.toString) private var logStatus: Bool = false

    var body: some View {
        ZStack {
            if logStatus {
//                HomepageView()
                AddEmergencyContactView()
            } else {
                LoginView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

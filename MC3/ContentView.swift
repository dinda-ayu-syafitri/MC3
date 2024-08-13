//
//  ContentView.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 09/08/24.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("logStatus") private var logStatus: Bool = false
    
    var body: some View {
        ZStack {
//            if logStatus {
                HomepageView()
//            } else {
//                LoginView()
//            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

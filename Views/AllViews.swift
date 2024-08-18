//
//  AllViews.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 16/08/24.
//

import SwiftUI

struct AllViews: View {
    var body: some View {
        TabView() {
            //Home View
            HomeView()
            
            //Settings View
            SettingsView(heartRateViewModel: HeartRateViewModel())
            
        }
        .tabViewStyle(.verticalPage)
    }
}

#Preview {
    AllViews()
}

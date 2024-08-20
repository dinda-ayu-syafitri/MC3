//
//  AllViews.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 16/08/24.
//

import SwiftUI

struct AllViews: View {
    var body: some View {
        RouterWatchView {
            TabView {
                // Home View
                Home()

                // Settings View
                SettingsView(homeVM: HomeViewModel())
            }
            .tabViewStyle(.verticalPage)
        }
    }
}

#Preview {
    AllViews()
}

//
//  HomeView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 14/08/24.
//

import SwiftUI

struct HomeView: View {
    @State var selectedTab: Router.Route.Tab

    var body: some View {
        TabView(selection: $selectedTab) {
            SOSView()
                .tabItem {
                    Label("SOS", systemImage: "sos.circle.fill")
                }
                .tag(Router.Route.Tab.sos)

            LiveTrackView()
                .tabItem {
                    Label("Live Track", systemImage: "map")
                }
                .tag(Router.Route.Tab.liveTrack)

            ProfileView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(Router.Route.Tab.settings)
        }
        .accentColor(.appPinkSecondary)
    }
}

#Preview {
    HomeView(selectedTab: .sos)
}

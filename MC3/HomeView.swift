//
//  HomeView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 14/08/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView(){
            SOSView()
                .tabItem {
                    Image(systemName: "sos.circle.fill")
                    Text("SOS")
                }
            LiveTrack()
                .tabItem {
                    Image(systemName: "map")
                    Text("Live Track")
                }
            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                    Text("Profile")
                }

        }
        .accentColor(.appPink)
    }
}

#Preview {
    HomeView()
}

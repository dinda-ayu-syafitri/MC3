//
//  RouterWatchView.swift
//  WatchMC3 Watch App
//
//  Created by Dinda Ayu Syafitri on 20/08/24.
//

import SwiftUI

struct RouterWatchView<Content: View>: View {
    @StateObject var router: RouterWatch = .init()
    // Our root view content
    private let content: Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: RouterWatch.Route.self) { route in
                    router.view(for: route)
                }
        }
        .environmentObject(router)
    }
}

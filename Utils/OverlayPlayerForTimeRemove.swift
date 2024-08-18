//
//  OverlayPlayerForTimeRemove.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 18/08/24.
//

import SwiftUI
import AVFoundation
import AVKit

struct OverlayPlayerForTimeRemove: View {
    var body: some View {
        OverlayPlayerForTimeRemove()
                .focusable(false)
                .disabled(true)
                .opacity(0)
                .allowsHitTesting(false)
                .accessibilityHidden(true)
    }
}

#Preview {
    OverlayPlayerForTimeRemove()
}

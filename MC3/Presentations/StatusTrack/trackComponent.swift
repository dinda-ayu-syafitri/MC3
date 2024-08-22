//
//  trackComponent.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import SwiftUI
import MapKit

struct trackComponent: View {
    @EnvironmentObject var trackedVM: StatusTrackViewModel
    
    var body: some View {
        VStack {
            MapComponent()
            .overlay(
                Text(trackedVM.status == 1 ?
                     "SOS Alert has been sent!" : "Ayah is tracking you!"
                    )
                .font(.title2)
                .bold()
                .foregroundColor(.maroonBrand)
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(12),
                alignment: .top
            )
        }
//        .padding(4)
    }
}

#Preview {
    trackComponent()
}

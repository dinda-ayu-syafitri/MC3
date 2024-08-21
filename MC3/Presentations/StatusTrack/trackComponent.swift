//
//  trackComponent.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import SwiftUI
import MapKit

struct trackComponent: View {
    @EnvironmentObject var statusTrackVM: StatusTrackViewModel
    @EnvironmentObject var socketVM: SocketHelper
    @EnvironmentObject var trackedVM: StatusTrackViewModel
    
    var body: some View {
        VStack {
            Map(position: $socketVM.mapCamera) {
                ForEach(Array(socketVM.userLocations.keys), id: \.self) { userId in
                    if let coordinate = socketVM.userLocations[userId] {
                        Annotation("User \(userId)", coordinate: coordinate) {
                            UserAnnotation() 
                        }
                    }
                }
            }
            .mapControls {
                MapPitchToggle()
                MapCompass()
                MapUserLocationButton()
            }
            .frame(height: 550)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .overlay(
                Text(statusTrackVM.status == 1 ?
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
        .padding(4)
    }
}

#Preview {
    trackComponent()
}

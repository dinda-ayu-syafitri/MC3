//
//  MapComponent.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 22/08/24.
//

import SwiftUI
import MapKit

struct MapComponent: View {
    @EnvironmentObject var locationVM: LocationManager
    @EnvironmentObject var socketVM: SocketHelper
    
    var body: some View {
        Map(position: $socketVM.mapCamera) {
            Annotation("User \(locationVM.userNumber)", coordinate: socketVM.userLocations[locationVM.userNumber] ?? locationVM.lastKnownLocation) {
                UserAnnotation()
            }
            
            ForEach(Array(socketVM.userLocations.keys).filter { $0 != locationVM.userNumber }, id: \.self) { userId in
                if let coordinate = socketVM.userLocations[userId] {
                    Annotation("User \(userId)", coordinate: coordinate) {
                        MarkerLogo()
                    }
                }
            }
        }
        .frame(height: 550)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}

#Preview {
    MapComponent()
}

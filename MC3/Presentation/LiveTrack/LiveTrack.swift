//
//  LiveTrack.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import SwiftUI
import MapKit

struct LiveTrack: View {
    @StateObject private var socketVM = SocketHelper()
    @State var isTracking = false
    
    var body: some View {
        VStack {
            Text("Live Track")
                .font(.largeTitle)
                .bold()
                .padding()
            
            if (isTracking) {
                Text("Tracking")
            } else {
                ZStack {
                    Map(position: $socketVM.mapCamera) {
                        Annotation("Victim Location", coordinate: CLLocationCoordinate2D(latitude: socketVM.latitude, longitude: socketVM.longitude)) {
                            UserAnnotation()
                        }
                    }
                    .background(.black.opacity(0.3))
                    
                    Text("No Active Alerts")
                        .font(.title3)
                        .bold()
                    
                    Text("You will be notified if somebody activated the SOS alert")
                        .font(.caption)
                }
                .padding()
            }
        }
    }
}

#Preview {
    LiveTrack()
}

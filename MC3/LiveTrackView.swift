//
//  LiveTrackView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 15/08/24.
//

import MapKit
import SwiftUI

struct LiveTrackView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -6.302062993687138, longitude: 106.65229908106305),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @StateObject private var service = SocketHelper()

    var showLiveTrack = true

    var body: some View {
        if showLiveTrack {
            VStack {
                Text("Live Track")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.red)

                Map(position: $service.mapCamera) {
                    Annotation("Victim Location", coordinate: CLLocationCoordinate2D(latitude: service.latitude, longitude: service.longitude)) {
//                        UserAnnotation()
                        Text("Hai")
                            .bold()
                            .font(.title)
                    }
                }
                .frame(height: 550)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .padding()
                .overlay(
                    VStack(alignment: .leading) {
                        Text("Current Location")
                            .font(.headline)
                            .padding(.bottom, 2)

                        Text("Kompleks Ruko Flourite, Jl. Raya Kelapa Gading Utara No.49, Tangerang Selatan")
                            .font(.subheadline)
                    }
                    .frame(width: 300)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: 5)
                    .padding(.top, 30),
                    alignment: .top
                )

//                Map(coordinateRegion: $region, showsUserLocation: true, userTrackingMode: .constant(.follow))
//                    .frame(height: 550)
//                    .clipShape(RoundedRectangle(cornerRadius: 20))
//                    .padding()
//                    .overlay(
//                        VStack(alignment: .leading) {
//                            Text("Current Location")
//                                .font(.headline)
//                                .padding(.bottom, 2)
//
//                            Text("Kompleks Ruko Flourite, Jl. Raya Kelapa Gading Utara No.49, Tangerang Selatan")
//                                .font(.subheadline)
//                        }
//                        .frame(width: 300)
//                        .padding()
//                        .background(Color.white)
//                        .clipShape(RoundedRectangle(cornerRadius: 10))
//                        .shadow(radius: 5)
//                        .padding(.top,30),
//                        alignment: .top
//                    )

                HStack {
                    HStack {
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 40, height: 40)
                            .overlay(
                                Text("S")
                                    .font(.headline)
                                    .foregroundColor(.white)
                            )
                        Text("Syafiqah")
                            .font(.headline)
                            .padding(.leading, 5)
                    }
                    .frame(width: 250, height: 35)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    Button(action: {
                        // Call action
                    }) {
                        Image(systemName: "phone.arrow.up.right")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                Spacer()
            }

        } else {
            NoAlertsView()
        }
    }
}

#Preview {
    LiveTrackView()
}

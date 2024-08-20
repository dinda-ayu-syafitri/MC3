//
//  LiveTrackView.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import SwiftUI
import MapKit

struct LiveTrackView: View {
    @StateObject private var socketVM = SocketHelper()
    @StateObject private var liveTrackVM = LiveTrackViewModel()
    
    var body: some View {
        if liveTrackVM.showLiveTrack {
            VStack {
                Text("Live Track")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.red)
                
                Text("longlat: \(socketVM.longitude), \(socketVM.latitude)")
                
                Map(position: $socketVM.mapCamera) {
                    Annotation("Victim Location", coordinate: CLLocationCoordinate2D(latitude: socketVM.latitude, longitude: socketVM.longitude)) {
                        UserAnnotation()
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
                
                HStack {
                    HStack {
                        Image(systemName: "person.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.black))
                        
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
            .onAppear {
                socketVM.setupSocket {
                    socketVM.createOrJoinRoom(roomName: "realTest", isListener: true)
                }
            }
            .onDisappear {
                socketVM.disconnectSocket()
            }
        } else {
            NoAlertsView()
        }
    }
}

#Preview {
    LiveTrackView()
}

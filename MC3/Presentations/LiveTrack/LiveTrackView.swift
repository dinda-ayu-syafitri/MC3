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
                    .foregroundColor(.appPink)
                
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
                    Button {
                        //action goes here
                    } label: {
                        HStack {
                            Image(systemName: "person.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color.white)
                                .padding()
                            
                            Text("Syafiqah")
                                .font(.headline)
                                .padding(.leading, 5)
                                .foregroundStyle(Color.white)
                                .bold()
                                .padding(.horizontal,-10)
                            
                            Spacer()
                            Image(systemName: "phone.arrow.up.right.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .padding()
                            
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                        .frame(width: 320, height: 35)
                        .padding()
                        .background(Color.appPink)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                Spacer()
            }
            .onAppear {
                socketVM.setupSocket {
                    socketVM.createOrJoinRoom(roomName: "testing", isListener: true)
                }
            }
            .onDisappear {
                socketVM.disconnectSocket()
            }
            .background(Color.bg)
        } else {
            NoAlertsView()
        }
    }
}

#Preview {
    LiveTrackView()
}

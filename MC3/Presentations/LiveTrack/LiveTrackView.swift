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
    @StateObject private var locationVM = LocationManager()
    
    var body: some View {
        if liveTrackVM.showLiveTrack {
            VStack {
                Text("Live Track")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.appPink)
                
                MapComponent()
                    .environmentObject(socketVM)
                    .environmentObject(locationVM)
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
            .padding()
            .onAppear {
                locationVM.checkLocationAuthorization()
                socketVM.getInitializeMapCamera(center: locationVM.lastKnownLocation)
            }
            .onChange(of: locationVM.userAcceptLocation) { oldValue, newValue in
                if (newValue) {
                    socketVM.setupSocket {
                        socketVM.createOrJoinRoom(roomName: "realTest", isListener: true)
                    }
                }
            }
            .onChange(of: locationVM.lastKnownLocation) { oldValue, newValue in
                socketVM.sendMessageToRoom(roomName: "realTest", message: [
                    "longitude" : (locationVM.lastKnownLocation.longitude) as Double,
                    "latitude" : (locationVM.lastKnownLocation.latitude) as Double,
                    "user" : locationVM.userNumber
                ])
            }
            .alert("Location Access Needed", isPresented: $locationVM.alertingAlwaysUseLocation) {
                Button("Go to Settings") {
                    if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                        UserDefaults.standard.setValue(true, forKey: KeyUserDefaultEnum.locationPrivacy.toString)
                        UIApplication.shared.open(appSettings)
                    }
                }
                Button("Cancel", role: .cancel) { }
            } message: {
                Text("This app requires access to your location at all times to provide certain features. Please go to Settings and enable 'Always' location access.")
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

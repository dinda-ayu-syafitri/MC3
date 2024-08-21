//
//  StatusTrackView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 19/08/24.
//

import SwiftUI

struct StatusTrackView: View {
    @EnvironmentObject var router: Router
    @StateObject private var trackedVM = StatusTrackViewModel()
    @StateObject private var locationVM = LocationManager()
    @StateObject private var socketVM = SocketHelper()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 24) {
                VStack {
                    trackComponent()
                        .environmentObject(locationVM)
                        .environmentObject(socketVM)
                        .environmentObject(trackedVM)
                    
                    if let coordinate = locationVM.lastKnownLocation {
                        Text("Latitude: \(coordinate.latitude)")
                            .foregroundStyle(.blackBrand)
                            .font(.caption)
                        
                        Text("Longitude: \(coordinate.longitude)")
                            .foregroundStyle(.blackBrand)
                            .font(.caption)
                    } else {
                        Text("Unknown Location")
                            .foregroundStyle(.blackBrand)
                            .font(.caption)
                    }
                }
                
                VStack(alignment: .center, spacing: 12) {
                    Button {
                        trackedVM.makeCall()
                    } label: {
                        Text("Call Siapa")
                            .font(.title2)
                            .foregroundStyle(Color.white)
                            .bold()
                            .padding(.vertical, 46)
                            .frame(maxWidth: .infinity)
                            .background(.redBrand)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    
                    Button {
                        trackedVM.isSheetOpened = true
                    } label: {
                        Text("Deactivate Alert")
                            .font(.headline)
                            .foregroundStyle(.yellowBrand)
                    }
                }
            }
        }
        .sheet(isPresented: $trackedVM.isSheetOpened, content: {
            DeactivateView(isActive: $trackedVM.isSheetOpened)
        })
        .padding(.horizontal, 16)
        .padding(.top, 98)
        .padding(.bottom, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.grayBrand)
        .ignoresSafeArea()
        .onAppear {
            locationVM.checkLocationAuthorization()
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
                "longitude" : (locationVM.lastKnownLocation?.longitude)! as Double,
                "latitude" : (locationVM.lastKnownLocation?.latitude)! as Double,
                "user" : locationVM.userNumber
            ])
        }
        .onDisappear {
            socketVM.disconnectSocket()
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
    }
}

#Preview {
    StatusTrackView()
}

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
        VStack {
            Spacer()
            VStack {
                if trackedVM.status == 1 {
                    sentComponent()
                } else {
                    trackComponent()
                }
            }
            
            if let coordinate = locationVM.lastKnownLocation {
                Text("Latitude: \(coordinate.latitude)")
                    .foregroundStyle(.blackBrand)
                    .font(.headline)
                
                Text("Longitude: \(coordinate.longitude)")
                    .foregroundStyle(.blackBrand)
                    .font(.headline)
            } else {
                Text("Unknown Location")
            }
            
            
            VStack{
                Button {
                    
                } label: {
                    ZStack{
                        RoundedRectangle(cornerRadius: 15.0)
                            .frame(width: 340, height: 100)
                            .foregroundStyle(Color.darkPinkBrand)
                        Text("Call Primary Emergency Contact")
                            .foregroundStyle(Color.white)
                            .bold()
                    }
                }
                .padding()
                
                Button {
                    
                } label: {
                    Text("Call emergency service - 112")
                        .font(.headline)
                        .foregroundColor(Color.maroonBrand)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.maroonBrand, lineWidth: 1)
                                .frame(width: 340, height: 100)
                        )
                }
                .padding()
                
                Button {
                    print("open sheet")
                    trackedVM.isSheetOpened = true
                } label: {
                    Text("Deactivate Alert")
                        .foregroundStyle(Color.maroonBrand)
                        .bold()
                }
                .padding(.top,20)
                
            }
            Spacer()
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
            print("longitude: \(String(describing: locationVM.lastKnownLocation?.longitude))")
            print("latitude: \(String(describing: locationVM.lastKnownLocation?.latitude))")
            
            socketVM.sendMessageToRoom(roomName: "realTest", message: [
                "longitude" : (locationVM.lastKnownLocation?.longitude)! as Double,
                "latitude" : (locationVM.lastKnownLocation?.latitude)! as Double
            ])
        }
        .onDisappear {
            socketVM.disconnectSocket()
        }
        .alert("Location Access Needed", isPresented: $locationVM.alertingAlwaysUseLocation) {
            Button("Go to Settings") {
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    locationVM.userAcceptLocation = false
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

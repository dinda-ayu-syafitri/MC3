//
//  StatusTrackView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 19/08/24.
//

import SwiftUI

struct StatusTrackView: View {
    @State private var status: Int = 2
    @EnvironmentObject var router: Router
    @State private var isOpened: Bool = false
    @StateObject private var locationVM = LocationManager()
    @StateObject private var socketVM = SocketHelper()
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                if status == 1 {
                    sentComponent()
                } else {
                    trackComponent()
                }
            }
            
            if let coordinate = locationVM.lastKnownLocation {
                Text("Latitude: \(coordinate.latitude)")
                
                Text("Longitude: \(coordinate.longitude)")
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
                    self.isOpened = true
                } label: {
                    Text("Deactivate Alert")
                        .foregroundStyle(Color.maroonBrand)
                        .bold()
                }
                .padding(.top,20)
                
            }
            Spacer()
        }
        .sheet(isPresented: $isOpened, content: {
            DeactivateView(isActive: $isOpened)
        })
        .padding(.horizontal, 16)
        .padding(.top, 98)
        .padding(.bottom, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.grayBrand)
        .ignoresSafeArea()
        .onAppear {
            locationVM.checkLocationAuthorization()
            socketVM.setupSocket {
                socketVM.createOrJoinRoom(roomName: "realTest", isListener: true)
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
    }
}

#Preview {
    StatusTrackView()
}

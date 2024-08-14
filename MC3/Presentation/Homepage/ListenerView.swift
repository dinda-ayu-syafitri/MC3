//
//  ListenerView.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 12/08/24.
//

import SwiftUI
import MapKit

struct ListenerView: View {
    @StateObject private var homepageVM = HomepageViewModel()
    @StateObject var service = SocketHelper()
    
    var body: some View {
        VStack {
            Text("Listener View testing")
                .font(.largeTitle)
                .padding()
            
            Text("Data:")
            Text(service.messages)
                .padding()
            
            Text("long lat: \(service.longitude), \(service.latitude)")
            
            Map(position: $service.mapCamera) {
                Annotation("Victim Location", coordinate: CLLocationCoordinate2D(latitude: service.latitude, longitude: service.longitude)) {
                    UserAnnotation()
                }
            }
            
            Spacer()
            
//            Button(action: {
////                service.publishMessage(socketReceiver: "Publisher")
//            }, label: {
//                Text("Send data to device 1")
//                    .foregroundStyle(.white)
//                    .frame(width: 300)
//                    .padding()
//                    .background(.yellow)
//            })
        }
        .onAppear {
            service.setUpCreateOrJoinRoom(roomeName: "Listener", isListener: true)
        }
        .onDisappear {
            service.disconnectSocket()
        }
        .navigationTitle("Listener")
    }
}

struct UserAnnotation: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 48, height: 48)
                .foregroundStyle(Color.blue.opacity(0.3))
            
            Circle()
                .frame(width: 32, height: 32)
                .foregroundStyle(.white)
            
            Circle()
                .frame(width: 16, height: 16)
                .foregroundStyle(Color.blue)
        }
    }
}

#Preview {
    ListenerView()
}

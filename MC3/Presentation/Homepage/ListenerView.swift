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
            Text("Listener View Port1")
                .font(.largeTitle)
                .padding()
            
            Text("Data:")
            Text(service.messages)
                .padding()
            
//            Map(position: $homepageVM.mapCamera) {
//                Annotation("My Location", coordinate: CLLocationCoordinate2D(latitude: service.longitude, longitude: service.latitude)) {
//                    UserAnnotation()
//                }
//            }
//            
            Spacer()
            
            Button(action: {
                service.publishMessage(toPort: "Port2", fromPort: "Port1")
            }, label: {
                Text("Send data to device 1")
                    .foregroundStyle(.white)
                    .frame(width: 300)
                    .padding()
                    .background(.yellow)
            })
        }
        .onAppear {
            service.listenSocket(port: "Port1")
        }
        .onDisappear {
            service.disconnectSocket()
            service.stopListeningSocket(port: "Port1")
        }
        .navigationTitle("Listener")
    }
}

#Preview {
    ListenerView()
}

//
//  PublisherView.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 12/08/24.
//

import SwiftUI

struct PublisherView: View {
    @StateObject private var homepageVM = HomepageViewModel()
    @StateObject var service = SocketHelper()
    
    var body: some View {
        VStack {
            Text("Publisher View Port2")
                .font(.largeTitle)
                .padding()
            
            Text("Data:")
            Text(service.messages)
                .padding()
            
            Spacer()
            
            Button(action: {
                service.sendMessageToRoom(roomName: "Listener", message: [
                    "longitude": 106.656,
                    "latitude": -6.264
                ])
            }, label: {
                Text("Send data to device 2")
                    .foregroundStyle(.white)
                    .frame(width: 300)
                    .padding()
                    .background(.yellow)
            })
        }
        .onAppear {
            service.setUpCreateOrJoinRoom(roomeName: "Listener", isListener: false)
        }
        .onDisappear {
            service.disconnectSocket()
        }
        .navigationTitle("Publisher")
    }
}

#Preview {
    PublisherView()
}

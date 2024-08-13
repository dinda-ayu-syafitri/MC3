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
                service.publishMessage(toPort: "Port1", fromPort: "Port2")
            }, label: {
                Text("Send data to device 2")
                    .foregroundStyle(.white)
                    .frame(width: 300)
                    .padding()
                    .background(.yellow)
            })
        }
        .onAppear {
            service.listenSocket(port: "Port2")
        }
        .onDisappear {
            service.disconnectSocket()
            service.stopListeningSocket(port: "Port2")
        }
        .navigationTitle("Publisher")
    }
}

#Preview {
    PublisherView()
}

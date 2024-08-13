//
//  SocketHelper.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 13/08/24.
//

import Foundation
import SocketIO

final class SocketHelper: ObservableObject {
    private var manager: SocketManager!
    private var socket: SocketIOClient!
    @Published var messages: String = ""
    
    init() {
        setupSocket()
    }
    
    private func setupSocket() {
        guard socket == nil else { return }
        
        manager = SocketManager(socketURL: URL(string: "ws://localhost:3000")!, config: [.log(true), .compress])
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect, callback: { (data, ack) in
            print("Connected")
            self.socket.emit("NodeJS Server Port", "Hi Node.JS Server!")
        })
        
        socket.connect()
    }
    
    func listenSocket(port: String) {
        print("Listening for iOS Client \(port)")
        socket.on("iOS Client \(port)") { [weak self] (data, ack) in
            guard let dataString = data.first as? String else {
                print("Received data is not a string")
                return
            }
            
            print("Received raw data: \(dataString)")
            
            // Parse JSON string
            if let data = dataString.data(using: .utf8),
               let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
               let longitude = json["longitude"],
               let latitude = json["latitude"] {
                
                DispatchQueue.main.async {
                    self?.messages = "\(longitude), \(latitude)"
                    print("Appended message: Longitude: \(longitude), Latitude: \(latitude)")
                }
            } else {
                print("Failed to parse JSON")
            }
        }
    }
    
    func publishMessage(toPort: String, fromPort: String) {
        print("publish msg")
        let locationData = [
            "longitude": "sampleLongitude",
            "latitude": "sampleLatitude"
        ]
        if let jsonData = try? JSONSerialization.data(withJSONObject: locationData, options: .prettyPrinted),
           let jsonString = String(data: jsonData, encoding: .utf8) {
            socket.emit("iOS Client \(toPort)", jsonString)
        }
    }
    
    func stopListeningSocket(port: String) {
        print("Stopping listening for iOS Client \(port)")
        socket.off("iOS Client \(port)")
    }
    
    func disconnectSocket() {
        socket.disconnect()
    }
    
    deinit {
        disconnectSocket()
    }
}

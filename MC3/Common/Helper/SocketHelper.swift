//
//  SocketHelper.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 13/08/24.
//

import Foundation
import SocketIO
import MapKit
import SwiftUI

final class SocketHelper: ObservableObject {
    private var manager: SocketManager!
    private var socket: SocketIOClient!
    @Published var messages: String = ""
    @Published var roomName: String = ""
    @Published var isListener: Bool = false
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    @Published var mapCamera: MapCameraPosition = .region(.userRegion)
    @Published var userLocations: [Double: CLLocationCoordinate2D] = [:]
    
    init() {
        self.mapRegion = .userRegion
    }
    
    func getInitializeMapCamera(center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)) {
        print("init map \(center)")
        self.mapCamera = .region(MKCoordinateRegion(center: center, latitudinalMeters: 5000, longitudinalMeters: 5000))
    }
    
    func setUpCreateOrJoinRoom(roomeName: String, isListener: Bool) {
        self.roomName = roomeName
        self.isListener = isListener
    }
    
    func setupSocket(completion: @escaping () -> Void) {
        guard self.socket == nil else {
            return
        }
        
        manager = SocketManager(socketURL: URL(string: "https://small-adaptive-efraasia.glitch.me")!, config: [.log(false), .compress, .forcePolling(true)])
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) { (data, ack) in
            print("Connected to server")
            self.socket.emit("Handshake", "Hi Node.JS Server!")
            completion()
        }
        
        socket.on(clientEvent: .error) { (data, ack) in
            print("Socket encountered an error: \(data)")
        }
        
        socket.on(clientEvent: .disconnect) { (data, ack) in
            print("Socket disconnected: \(data)")
        }
        
        socket.connect()
    }
    
    func createOrJoinRoom(roomName: String, isListener: Bool) {
        print("create or join room : \(roomName), \(isListener)")
        socket.emit("createRoom", roomName)
        
        if isListener {
            listenRoom(roomName: roomName)
        }
    }
    
    func listenRoom(roomName: String) {
        socket.on("message") { [weak self] (data, ack) in
            guard let message = data.first as? [String: Double],
                  let longitude = message["longitude"],
                  let latitude = message["latitude"],
                  let userId = message["user"] else {
                print("Failed to parse message when listening room")
                return
            }
            
            DispatchQueue.main.async {
                let userCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
                self?.userLocations[userId] = userCoordinate
            }
        }
    }

    func sendMessageToRoom(roomName: String, message: [String:Double]) {
        let data: [String: Any] = ["roomName": roomName, "message": message]
        socket.emit("sendMessageToRoom", data)
    }
    
    func stopListeningSocket(event: String) {
        socket.off("\(event)")
    }
    
    func disconnectSocket() {
        socket.disconnect()
        self.socket = nil
    }
    
    deinit {
        disconnectSocket()
        self.socket = nil
    }
}

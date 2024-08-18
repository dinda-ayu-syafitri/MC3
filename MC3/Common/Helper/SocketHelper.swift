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
    @Published var mapCamera: MapCameraPosition
    @Published var longitude: CLLocationDegrees = -6.303338
    @Published var latitude: CLLocationDegrees = 106.638168
    
    init() {
        self.mapRegion = .userRegion
        self.mapCamera = .region(.userRegion)
        self.setupSocket()
    }
    
    func setUpCreateOrJoinRoom(roomeName: String, isListener: Bool) {
        self.roomName = roomeName
        self.isListener = isListener
    }
    
    private func setupSocket() {
        guard socket == nil else { return }
        
        manager = SocketManager(socketURL: URL(string: "https://small-adaptive-efraasia.glitch.me")!, config: [.log(true), .compress, .forcePolling(true)])
        socket = manager.defaultSocket
        
        socket.on(clientEvent: .connect) { (data, ack) in
            print("Connected to server")
            self.socket.emit("Handshake", "Hi Node.JS Server!")
            self.createOrJoinRoom(roomName: self.roomName, isListener: self.isListener)
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
                  let latitude = message["latitude"] else {
                print("Failed to parse message when listening room")
                return
            }
            
            DispatchQueue.main.async {
                print("success get data")
                self?.messages = "Longitude: \(longitude), Latitude: \(latitude)"
                self?.longitude = longitude
                self?.latitude = latitude
                
                let newRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), latitudinalMeters: 1000, longitudinalMeters: 1000)
                self?.mapCamera = MapCameraPosition.region(newRegion)
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
    }
    
    deinit {
        disconnectSocket()
    }
}

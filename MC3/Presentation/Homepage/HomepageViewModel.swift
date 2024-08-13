//
//  HomepageModelView.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 11/08/24.
//

import Foundation
import FirebaseAuth
import AuthenticationServices
import GoogleSignIn
import SocketIO
import MapKit
import SwiftUI

class HomepageViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    @Published var mapRegion: MKCoordinateRegion = MKCoordinateRegion()
    @Published var mapCamera: MapCameraPosition
    
    init() {
        self.mapRegion = .userRegion
        self.mapCamera = .region(.userRegion)
        self.fetchUserInfo()
    }
    
    func fetchUserInfo() {
        if let user = Auth.auth().currentUser {
            self.userName = user.displayName ?? "No Name"
            self.userEmail = user.email ?? UserDefaults.standard.string(forKey: "userEmail") ?? "No Email"
        } else {
            print("No current user found in Firebase Auth")
            self.userName = "Not Found"
            self.userEmail = "Not Found"
        }
    }
    
    func logOut() {
        DispatchQueue.global(qos: .background).async {
            try? Auth.auth().signOut()
            GIDSignIn.sharedInstance.signOut()
        }
        
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "logStatus")
    }
}

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(
            center: .userLoct,
            latitudinalMeters: 10000,
            longitudinalMeters: 10000
        )
    }
}

extension CLLocationCoordinate2D {
    static var userLoct: CLLocationCoordinate2D {
        return .init(
            latitude: -6.303338,
            longitude: 106.638168
        )
    }
}

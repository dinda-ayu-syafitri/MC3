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

class HomepageViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var userEmail: String = ""
    
    init() {
        fetchUserInfo()
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

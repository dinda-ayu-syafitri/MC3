//
//  HomepageModelView.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 11/08/24.
//

import Foundation
import FirebaseAuth
import AuthenticationServices

class HomepageViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var userEmail: String = ""

    init() {
        fetchUserInfo()
    }

    func fetchUserInfo() {
        guard let userId = UserDefaults.standard.string(forKey: "userId") else {
            print("User ID not found in UserDefaults")
            return
        }

        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userId) { (credentialState, error) in
            DispatchQueue.main.async {
                switch credentialState {
                case .authorized:
                    if let user = Auth.auth().currentUser {
                        self.userName = user.displayName ?? "No Name"
                        self.userEmail = user.email ?? "No Email"
                    }
                case .revoked, .notFound:
                    print("Credential revoked or not found")
                    self.userName = "Not Found"
                    self.userEmail = UserDefaults.standard.string(forKey: "userEmail") ?? "Not Found"
                default:
                    break
                }
            }
        }
    }
    
    func logOut() {
        DispatchQueue.global(qos: .background).async {
            try? Auth.auth().signOut()
        }
        
        UserDefaults.standard.removeObject(forKey: "userId")
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "logStatus")
        print("Logged out, status: ", UserDefaults.standard.bool(forKey: "logStatus"))
    }
}

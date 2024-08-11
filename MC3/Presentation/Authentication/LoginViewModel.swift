//
//  LoginViewModel.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 11/08/24.
//

import Foundation
import AuthenticationServices
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var nonce: String = ""
    
    func getAuthenticate(user: ASAuthorization) {
        guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
            print("Error when getAuthenticate")
            return
        }
        
        self.authenticate(credential: credential)
    }
    
    func authenticate(credential: ASAuthorizationAppleIDCredential) {
        guard let token = credential.identityToken else {
            print("Error when get a token")
            return
        }
        
        guard let tokenSring = String(data: token, encoding: .utf8) else {
            print("Error when get a string token")
            return
        }
        
        let firebaseCredential = OAuthProvider.credential(
            providerID: AuthProviderID(rawValue: "apple.com")!,
            idToken: tokenSring,
            rawNonce: nonce
        )
        
        Auth.auth().signIn(with: firebaseCredential) { (result, err) in
            if let error = err {
                print("error auth: ", error.localizedDescription)
                return
            }
            
            guard let user = result?.user else {
                print("Error: No user data")
                return
            }
            
            print("Successfully logged in with Apple ID")
            print("User ID: \(user.uid)")
            print("User Email: \(user.email ?? "No Email")")
            
            // Save user email and login status
            UserDefaults.standard.set(user.email, forKey: "userEmail")
            UserDefaults.standard.set(user.uid, forKey: "userId")
            UserDefaults.standard.set(true, forKey: "logStatus")
        }
    }
}

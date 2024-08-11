//
//  LoginViewModel.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 11/08/24.
//

import Foundation
import SwiftUI
import AuthenticationServices
import FirebaseAuth
import GoogleSignIn

class LoginViewModel: ObservableObject {
    @Published var nonce: String = ""
    
    func getAuthenticate(user: ASAuthorization) {
        guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
            print("Error when getAuthenticate")
            return
        }
        
        self.authenticate(credential: credential)
    }
    
    func authByGoogle(user: GIDGoogleUser) {
        Task {
            do {
                guard let idToken = user.idToken?.tokenString else {
                    print("Error: Missing ID token")
                    return
                }
                let accessToken = user.accessToken.tokenString
                
                let credential = OAuthProvider.credential(
                    providerID: AuthProviderID(rawValue: "google.com")!,
                    idToken: idToken,
                    accessToken: accessToken
                )
                
                try await Auth.auth().signIn(with: credential)
                
                if let email = user.profile?.email {
                    UserDefaults.standard.set(email, forKey: "userEmail")
                }
                if let name = user.profile?.name {
                    UserDefaults.standard.set(name, forKey: "userName")
                }
                
                print("Logged in by Google")
                
                await MainActor.run(body: {
                    withAnimation(.easeInOut) {
                        UserDefaults.standard.set(true, forKey: "logStatus")
                    }
                })
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func authenticate(credential: ASAuthorizationAppleIDCredential) {
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
            
            withAnimation(.easeInOut) {
                UserDefaults.standard.set(user.email, forKey: "userEmail")
                UserDefaults.standard.set(user.uid, forKey: "userId")
                UserDefaults.standard.set(true, forKey: "logStatus")
            }
        }
    }
}

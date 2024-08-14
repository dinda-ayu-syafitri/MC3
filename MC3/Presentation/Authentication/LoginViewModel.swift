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
import Firebase
import FirebaseFirestore
import GoogleSignIn

class LoginViewModel: ObservableObject {
    @Published var nonce: String = ""
    @Published var userModel: User =  User()
    private var firebaseUseCase: FirebaseServiceUseCaseProtocol
    
    init(firebaseUseCase: FirebaseServiceUseCaseProtocol) {
        self.firebaseUseCase = firebaseUseCase
    }
    
    func appleRequest(request: ASAuthorizationAppleIDRequest) {
        self.nonce = randomNonceString()
        request.requestedScopes = [.email, .fullName]
        request.nonce = sha256(self.nonce)
    }
    
    func appleCompletion(result: Result<ASAuthorization, any Error>) {
        switch result {
        case .success(let user):
            guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                print("Error when getAuthenticate")
                return
            }
            self.authenticateByApple(credential: credential)
            
        case .failure(let error):
            print(error.localizedDescription)
        }
    }
    
    func googleRequestAuth(signInResult: GIDSignInResult?, error: (any Error)?) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        if let signInResult = signInResult {
            let user = signInResult.user
            self.authByGoogle(user: user)
        }
    }
    
    private func authByGoogle(user: GIDGoogleUser) {
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
                
                let firebaseID = Auth.auth().currentUser?.uid
                if firebaseID != nil {
                    UserDefaults.standard.set(firebaseID, forKey: "firebaseID")
//                    self.sendFirebaseIdToDB(idFirestore: firebaseID!)
                    await self.registeringAccount(idFirestore: firebaseID!, fcm: "testing")
                }
                
                if let email = user.profile?.email {
                    UserDefaults.standard.set(email, forKey: "userEmail")
                }
                if let name = user.profile?.name {
                    UserDefaults.standard.set(name, forKey: "userName")
                }
                
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
    
    private func authenticateByApple(credential: ASAuthorizationAppleIDCredential) {
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
            
            Task {
                await self.registeringAccount(idFirestore: user.uid, fcm: "testing")
                
                withAnimation(.easeInOut) {
                    UserDefaults.standard.set(user.email, forKey: "userEmail")
                    print("email : ", UserDefaults.standard.string(forKey: "userEmail") ?? "no data")
                    UserDefaults.standard.set(user.uid, forKey: "firebaseID")
                    UserDefaults.standard.set(true, forKey: "logStatus")
                }
            }
        }
    }
    
    @MainActor
    func registeringAccount(idFirestore: String, fcm: String) async {
        do {
            try await firebaseUseCase.registerAccount(idFirestore: idFirestore, fcm: fcm)
        } catch {
            print("error while registering on vm : \(error.localizedDescription)")
        }
    }
}

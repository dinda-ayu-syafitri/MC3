//
//  LoginViewModel.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 11/08/24.
//

import AuthenticationServices
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Foundation
import GoogleSignIn
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var nonce: String = ""
    @Published var isLoading: Bool = false
    @Published var userModel: User = .init()
    private var firebaseUseCase: FirebaseServiceUseCaseProtocol
    private var userDefaultUseCase: UserDefaultUseCaseProtocol

    init(firebaseUseCase: FirebaseServiceUseCaseProtocol, userDefaultUseCase: UserDefaultUseCaseProtocol) {
        self.firebaseUseCase = firebaseUseCase
        self.userDefaultUseCase = userDefaultUseCase
    }

    func appleRequest(request: ASAuthorizationAppleIDRequest) {
        self.isLoading = true
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
        self.isLoading = false
    }

    @MainActor
    func googleRequestAuth(signInResult: GIDSignInResult?, error: (any Error)?) async {
        self.isLoading = true
        if let error = error {
            print(error.localizedDescription)
            self.isLoading = false
            return
        }

        if let signInResult = signInResult {
            let user = signInResult.user
            await self.authByGoogle(user: user)
        }
        self.isLoading = false
    }

    private func authByGoogle(user: GIDGoogleUser) async {
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

            let fcmToken = TokenManager.shared.fcmToken ?? ""
            await self.registeringAccount(idFirestore: firebaseID!, fcm: fcmToken)
            self.userDefaultUseCase.saveLoginData(email: user.profile?.email ?? "", firebaseID: firebaseID ?? "")
        } catch {
            print(error.localizedDescription)
        }
    }

    private func authenticateByApple(credential: ASAuthorizationAppleIDCredential) {
        guard let token = credential.identityToken else {
            print("Error when get a token")
            return
        }

        guard let idToken = String(data: token, encoding: .utf8) else {
            print("Error when get a string token")
            return
        }

        let firebaseCredential = OAuthProvider.credential(
            providerID: AuthProviderID(rawValue: "apple.com")!,
            idToken: idToken,
            rawNonce: self.nonce
        )

        Auth.auth().signIn(with: firebaseCredential) { result, err in
            if let error = err {
                print("error auth: ", error.localizedDescription)
                return
            }

            guard let user = result?.user else {
                print("Error: No user data")
                return
            }

            Task {
                let fcmToken = TokenManager.shared.fcmToken ?? ""
                await self.registeringAccount(idFirestore: user.uid, fcm: fcmToken)
                self.userDefaultUseCase.saveLoginData(email: user.email ?? "", firebaseID: user.uid)
            }
        }
    }

    @MainActor
    func registeringAccount(idFirestore: String, fcm: String) async {
        do {
            try await self.firebaseUseCase.registerAccount(idFirestore: idFirestore, fcm: fcm)
        } catch {
            print("error while registering on vm : \(error.localizedDescription)")
        }
    }
}

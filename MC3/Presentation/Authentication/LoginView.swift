//
//  LoginView.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 11/08/24.
//

import SwiftUI
import AuthenticationServices
import GoogleSignIn
import GoogleSignInSwift
import Firebase

struct LoginView: View {
    @StateObject var loginVM = LoginViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Login Page")
                .padding(.bottom, 16)
            Spacer()
            
            SignInWithAppleButton(onRequest: { (request) in
                loginVM.nonce = randomNonceString()
                request.requestedScopes = [.email, .fullName]
                request.nonce = sha256(loginVM.nonce)
            }, onCompletion: { (result) in
                switch result {
                case .success(let user):
                    print("Success!")
                    loginVM.getAuthenticate(user: user)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                }
            })
            .signInWithAppleButtonStyle(.black)
            .frame(height: 50)
            .clipShape(Capsule())
            .padding(.horizontal, 30)
            
            HStack {
                VStack {
                    Divider().background(.gray)
                }
                .padding(16)
                
                Text("OR")
                    .font(.headline)
                    .foregroundColor(.gray)
                
                VStack {
                    Divider().background(.gray)
                }
                .padding(16)
            }
            .padding(.horizontal)
            
            GoogleSignInButton {
                GIDSignIn.sharedInstance.signIn(
                    withPresenting: UIApplication.shared.rootController()
                ) { signInResult, error in
                    if let error = error {
                        print(error.localizedDescription)
                        return
                    }

                    if let signInResult = signInResult {
                        let user = signInResult.user
                        loginVM.authByGoogle(user: user)
                    }
                }
            }
            .frame(height: 50)
            .clipShape(Capsule())
            .overlay(
                Capsule()
                    .stroke(Color.blue, lineWidth: 2)
            )
            .padding(.horizontal, 30)
        }
    }
}



#Preview {
    LoginView()
}

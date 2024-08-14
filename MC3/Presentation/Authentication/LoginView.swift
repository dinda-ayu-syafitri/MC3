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
    @StateObject var loginVM = DependencyInjection.shared.loginViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Login Page")
                .padding(.bottom, 16)
            Spacer()
            
            SignInWithAppleButton(onRequest: { (request) in
                loginVM.appleRequest(request: request)
            }, onCompletion: { (result) in
                loginVM.appleCompletion(result: result)
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
                    loginVM.googleRequestAuth(signInResult: signInResult, error: error)
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
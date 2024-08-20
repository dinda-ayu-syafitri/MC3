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
            Text("Sign in")
                .font(.title2)
                .bold()
                .padding(.top, 16)
                .padding(.bottom, 32)
            
            HStack(alignment: .center, spacing: 12) {
                Image(systemName: "apple.logo")
                    .font(.headline)
                    .foregroundStyle(.whiteBrand)
                
                Text("Sign in with Apple ID")
                    .font(.headline)
                    .foregroundStyle(.whiteBrand)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(.redBrand)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .overlay {
                SignInWithAppleButton(onRequest: { (request) in
                    loginVM.appleRequest(request: request)
                }, onCompletion: { (result) in
                    loginVM.appleCompletion(result: result)
                })
                .opacity(0.0101)
                .blendMode(.overlay)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
            }
            
            HStack(alignment: .center, spacing: 12) {
                Image(.googleLogo)
                    .font(.headline)
                    .foregroundStyle(.maroonBrand)
                
                Text("Sign in with Google")
                    .font(.headline)
                    .foregroundStyle(.maroonBrand)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(.grayBrand)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.maroonBrand, lineWidth: 1)
            )
            .overlay {
                GoogleSignInButton{
                    GIDSignIn.sharedInstance.signIn(
                        withPresenting: UIApplication.shared.rootController()
                    ) { signInResult, error in
                        Task {
                            await loginVM.googleRequestAuth(signInResult: signInResult, error: error)
                        }
                    }
                }
                .opacity(0.0101)
                .blendMode(.overlay)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .contentShape(Rectangle())
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 98)
        .padding(.bottom, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.grayBrand)
        .ignoresSafeArea()
    }
}


struct LoadingButton: View {
    var body: some View {
        HStack (alignment: .center, spacing: 8) {
            ProgressView()
                .foregroundStyle(.white)
            Text("Please wait a seconds")
        }
        .foregroundStyle(.white)
        .frame(height: 50)
        .background(.black)
    }
}
//
//#Preview {
//    LoginView()
//}

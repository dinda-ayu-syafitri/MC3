//
//  LoginView.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 11/08/24.
//

import SwiftUI
import _AuthenticationServices_SwiftUI

struct LoginView: View {
    @StateObject var loginVM = LoginViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Login Page")
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
        }
    }
}



#Preview {
    LoginView()
}

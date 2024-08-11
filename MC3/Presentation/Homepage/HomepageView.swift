//
//  HomepageView.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 11/08/24.
//

import SwiftUI

struct HomepageView: View {
    @StateObject private var homepageVM = HomepageViewModel()
    
    var body: some View {
        VStack {
            Spacer()
            Text("Welcome, \(homepageVM.userName)")
                .font(.title)
                .padding(.bottom, 5)
            
            Text("Email: \(homepageVM.userEmail)")
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            
            Button(action: {
                homepageVM.logOut()
                
                print("Logged Out")
            }, label: {
                Text("Log Out")
                    .font(.headline)
                    .fontWeight(.bold)
                    .frame(width: 300)
                    .padding(.vertical, 14)
                    .padding(.horizontal, 32)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [.red, .orange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            })
        }
    }
}

#Preview {
    HomepageView()
}

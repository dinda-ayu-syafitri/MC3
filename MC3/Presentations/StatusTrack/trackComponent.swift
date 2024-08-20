//
//  trackComponent.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import SwiftUI

struct trackComponent: View {
    var body: some View {
        ZStack{
            Color.white
                .frame(width: 350, height: 400)
                .cornerRadius(10)
                .padding()
            
            VStack{
                
                Text("Emergency Contact is Tracking")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 8)
                
                Text("Your emergency contact is currently tracking you")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                Spacer().frame(height: 50)
                Image(systemName: "location.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color.maroonBrand)
            }
            
        }
    }
}

#Preview {
    trackComponent()
}

//
//  sentComponent.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import SwiftUI

struct sentComponent: View {
    var body: some View {
        ZStack{
            Color.white
                .frame(width: 350, height: 400)
                .cornerRadius(10)
                .padding()
            
            VStack{
                
                Text("SOS Alert Has Been Sent")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 8)
                
                Text("Emergency notifications has been sent to your emergency contacts")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                Spacer().frame(height: 50)
                Image(systemName: "checkmark.bubble.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundStyle(Color.maroonBrand)
            }
            
        }
    }
}
#Preview {
    sentComponent()
}

//
//  SOSView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 15/08/24.
//

import SwiftUI


struct SOSView: View {
    @State private var pulse = false
    @State private var bounce = false
    @State private var scale: CGFloat = 1.0
    var body: some View {
        
        Button(action: {
            
        }, label: {
            ZStack {
                Rectangle()
                     .frame(width: 350, height: 700)
                     .clipShape(RoundedRectangle(cornerRadius: 20))
                     .foregroundColor(.red)
                     .overlay(
                         Rectangle()
                             .frame(width: 350, height: 700)
                             .clipShape(RoundedRectangle(cornerRadius: 20))
                             .foregroundColor(.red)
                             .scaleEffect(pulse ? 1.05 : 1.0)
                             .opacity(pulse ? 0.0 : 1.0)
                     )
                     .offset(y: bounce ? -10 : 0) // Bounce effect
                     .animation(
                         Animation.easeInOut(duration: 0.7)
                             .repeatForever(autoreverses: true)
                     )
                     .onAppear {
                         self.pulse.toggle()
                         self.bounce.toggle()
                     }
                
                VStack {
                    Image(systemName: "bell.and.waves.left.and.right.fill")
                                .resizable()
                                .frame(width: 150, height: 100)
                                .foregroundColor(.white)
                                .scaleEffect(scale)
                                .onAppear {
                                    withAnimation(Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
                                        scale = 1.2
                                    }
                                }
                    
                    Text("Tap to activate SOS Alert")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                    
                    Text("Emergency alerts and live location will be sent to listed contacts")
                        .font(.subheadline)
                        .foregroundColor(.white)
                        .padding(.horizontal, 40)
                }
            }
        })
        
    }
}

#Preview {
    SOSView()
}

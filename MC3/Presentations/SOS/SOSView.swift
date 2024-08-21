//
//  SOSView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 14/08/24.
//

import SwiftUI

struct SOSView: View {
    @State private var pulse = false
    @State private var bounce = false
    @State private var scale: CGFloat = 1.0
    @EnvironmentObject var router: Router
    var body: some View {
        
        VStack {
                Button(action: {
                    
                }, label: {
                    ZStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20.0)
                                .fill(Color.appPink.opacity(0.3))
                                .frame(width: 320, height: 620)
                                .scaleEffect(pulse ? 1.08 : 0.8)
                            RoundedRectangle(cornerRadius: 20.0)
                                .fill(Color.appPink.opacity(0.5))
                                .frame(width: 310, height: 610)
                                .scaleEffect(pulse ? 1.04 : 0.8)
                            RoundedRectangle(cornerRadius: 20.0)
                                .fill(Color.appPink)
                                .frame(width: 300, height: 600)
                        }
                        .scaleEffect(bounce ? 1.05 : 1.05)
                        .onAppear {
                            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                                pulse.toggle()
                                bounce.toggle()
                            }
                        }
                        
                        VStack {
                            Image(systemName: "bell.and.waves.left.and.right.fill")
                                        .resizable()
                                        .frame(width: 150, height: 100)
                                        .foregroundColor(.white)
                                        .scaleEffect(scale)
                                        .onAppear {
                                            withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
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
                    .onTapGesture {
                        router.navigateTo(.CountdownView)
                    }
                    
            })
        }
        
    }
}

#Preview {
    SOSView()
}

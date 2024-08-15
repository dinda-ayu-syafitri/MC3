//
//  CountdownView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 15/08/24.
//

import SwiftUI

struct CountdownView: View {
    @State private var countdown = 5
    @State private var pulse = false
    @State private var bounce = false
    @State var viewState = CGSize(width: 0, height: 50)
    var body: some View {
        VStack {
            Spacer()
            
            Text("Alerting emergency contacts in")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .padding(.bottom, 10)
                .multilineTextAlignment(.center)
            Spacer()
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .scaleEffect(pulse ? 1.2 : 1.0)
                    .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true))
                
                Circle()
                    .fill(Color.white.opacity(0.1))
                    .scaleEffect(pulse ? 1.5 : 1.2)
                    .animation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true))
                
                // White circle behind the countdown number
                Circle()
                    .fill(Color.white)
                    .frame(width: 150, height: 150)
                
                Text("\(countdown)")
                    .font(.system(size: 100, weight: .bold))
                    .foregroundColor(.black)
            }
            .frame(width: 200, height: 200)
            .scaleEffect(bounce ? 1.05 : 1.0)
            .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true))
            .onAppear {
                pulse.toggle()
                bounce.toggle()
            }
            Spacer()
            VStack{
                Text("Tap the screen once to skip countdown and activate SOS alert immediately")
                .font(.subheadline)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
            }
            .padding()
            SlideToCancelButton()
            Spacer()
            
            
        }
        
        .ignoresSafeArea()
        .background(Color.red)
    }
}

struct SlideToCancelButton: View {
    @State private var offset: CGFloat = 20
    @State private var buttonWidth: CGFloat = UIScreen.main.bounds.width - 60 // Adjust the width based on your design
    
    var body: some View {
        ZStack {
            // Background track
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.white.opacity(0.3))
                .frame(width: buttonWidth, height: 85)
                .overlay(
                    Text("Slide to cancel")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                )
            
            // Draggable foreground
            HStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 70, height: 70)
                    .overlay(
                        Image(systemName: "arrow.right")
                            .foregroundColor(.red)
                            .font(.system(size: 24, weight: .bold))
                    )
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                // Move the button only within the width of the track
                                if gesture.translation.width > 0 && gesture.translation.width <= (buttonWidth - 70) {
                                    offset = gesture.translation.width
                                }
                            }
                            .onEnded { _ in
                                // If dragged to the end, trigger the cancel action
                                if offset > (buttonWidth - 140) {
                                    withAnimation {
                                        offset = buttonWidth - 70
                                    }
                                    // Perform your cancel action here
                                    print("Action Canceled")
                                } else {
                                    // Otherwise, reset the button
                                    withAnimation {
                                        offset = 20
                                    }
                                }
                            }
                    )
                
                Spacer()
            }
        }
        .padding(.horizontal)
    }
}
#Preview {
    CountdownView()
}

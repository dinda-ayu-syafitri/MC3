//
//  CountdownView.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 16/08/24.
//

import SwiftUI
import UIKit

struct CountdownView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // SOS State
            HStack {
                Text("SOS Inactive")
                    .font(.system(size: 17) .weight(.semibold))
                    .foregroundColor(.pastelPink)
                    .frame(alignment: .leading)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            VStack(spacing: 8) {
                // Headline/Regular
                Text("Alerting in")
                  .font(.system(size: 17)
                      .weight(.semibold))
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white)
                  .frame(maxWidth: .infinity, alignment: .top)
                
                Text("5")
                  .font(
                    Font.custom("SF Pro", size: 72)
                        .weight(.bold)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white)
                  .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                
                SlideToCancelButton()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea()
        .background(.black)
//        .navigationTitle("Countdown")
    }
}



#Preview {
    CountdownView()
}

struct SlideToCancelButton: View {
    @State private var offset: CGFloat = 8
    
    var body: some View {
        GeometryReader { geometry in
            let buttonWidth = geometry.size.width - 8 // Adjust the width based on your design
            
            ZStack {
                // Background track
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.white.opacity(0.3))
                    .frame(width: buttonWidth, height: 44)
                    .overlay(
                        Text("Cancel")
                            .frame(alignment: .center)
                            .padding(.leading)
                            .fontWeight(.bold)
                        
                    )
                
                // Draggable foreground
                HStack {
                    Circle()
                        .fill(Color.red)
                        .frame(width: 34, height: 34)
                        .overlay(
                            Image(systemName: "arrow.right")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .bold))
                        )
                        .offset(x: offset)
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    // Move the button only within the width of the track
                                    if gesture.translation.width > 0 && gesture.translation.width <= (buttonWidth - 35) {
                                        offset = gesture.translation.width
                                    }
                                }
                                .onEnded { _ in
                                    // If dragged to the end, trigger the cancel action
                                    if offset > (buttonWidth - 45) {
                                        withAnimation {
                                            offset = buttonWidth - 35
                                        }
                                        // Perform your cancel action here
                                        print("Action Canceled")
                                    } else {
                                        // Otherwise, reset the button
                                        withAnimation {
                                            offset = 8
                                        }
                                    }
                                }
                        )
                    
                    Spacer()
                }
            }
        }
    }
}

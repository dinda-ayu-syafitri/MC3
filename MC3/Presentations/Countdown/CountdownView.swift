//
//  CountdownView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 15/08/24.
//

import SwiftData
import SwiftUI

struct CountdownView: View {
    @State private var countdown = 5
    @State private var ripple1 = false
    @State private var ripple2 = false
    @State private var ripple3 = false
    @State private var isCountingDown = true
    @EnvironmentObject var router: Router
    @StateObject var messageVM = DependencyInjection.shared.MessageNotifViewModel()
    @Query private var emergencyContactSaved: [EmergencyContacts]
    @StateObject private var trackedVM = StatusTrackViewModel()

    var body: some View {
        VStack {
            Spacer()

            Text("Alerting emergency contacts in")
                .font(.title)
                .bold()
                .foregroundColor(.white)
                .padding(20)
                .multilineTextAlignment(.center)

            Spacer()
            ZStack {
                // Ripple effect layers
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 247.54, height: 247.54)
                    .scaleEffect(ripple1 ? 1.3 : 1.0)
                    .opacity(ripple1 ? 0 : 1)
                    .animation(Animation.easeOut(duration: 1.5).repeatForever(autoreverses: false), value: ripple1)
                    .onAppear {
                        ripple1.toggle()
                    }

                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 247.54, height: 247.54)
                    .scaleEffect(ripple2 ? 1.3 : 1.0)
                    .opacity(ripple2 ? 0 : 1)
                    .animation(Animation.easeOut(duration: 1.5).delay(0.5).repeatForever(autoreverses: false), value: ripple2)
                    .onAppear {
                        ripple2.toggle()
                    }

                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 247.54, height: 247.54)
                    .scaleEffect(ripple3 ? 1.3 : 1.0)
                    .opacity(ripple3 ? 0 : 1)
                    .animation(Animation.easeOut(duration: 1.5).delay(1.0).repeatForever(autoreverses: false), value: ripple3)
                    .onAppear {
                        ripple3.toggle()
                    }

                // White circle behind the countdown number
                Circle()
                    .fill(Color.white)
                    .frame(width: 247.54, height: 247.54)

                Text("\(countdown)")
                    .font(.system(size: 128, weight: .bold))
                    .foregroundColor(.black)
            }
            .onTapGesture {
                // Stop the countdown and navigate to StatusTrackView
                isCountingDown = false
                messageVM.startSendingNotifications(
                    emergencyContactSaved: emergencyContactSaved
                )
                router.navigateTo(.StatusTrackView)
            }
            .frame(width: 200, height: 200)
            .onAppear {
                startCountdown()
            }
            Spacer()
            VStack {
                Text("Tap screen to skip countdown")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
            .padding()
            Spacer()
            SlideToCancelButton()
            Spacer().frame(height: 40)
        }
        .ignoresSafeArea()
        .background(Gradient(colors: [Color.pinkLinearTopBrand, Color.pinkLinearBottomBrand]))
    }

    // Countdown function
    func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if countdown > 0 && isCountingDown {
                countdown -= 1
            } else {
                timer.invalidate()
                if isCountingDown { // Only navigate if the countdown finished normally
                    messageVM.startSendingNotifications(
                        emergencyContactSaved: emergencyContactSaved
                    )
                    emergencyContactSaved {
                        trackedVM.makeCall(phoneNumber: <#T##String#>)

                    }
                    router.navigateTo(.StatusTrackView)
                }
            }
        }
    }
}

struct SlideToCancelButton: View {
    @State private var offset: CGFloat = 8
    @State private var buttonWidth: CGFloat = UIScreen.main.bounds.width - 25 // Adjust the width based on your design
    @EnvironmentObject var router: Router
    var body: some View {
        ZStack {
            // Background track
            RoundedRectangle(cornerRadius: 40)
                .fill(Color.white.opacity(0.3))
                .frame(width: buttonWidth, height: 88)
                .overlay(
                    Text("Slide to cancel")
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                        .padding(.leading, 16)
                )

            // Draggable foreground
            HStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 72, height: 72)
                    .overlay(
                        Image(systemName: "arrow.right")
                            .foregroundColor(.appPink)
                            .font(.system(size: 24, weight: .bold))
                    )
                    .offset(x: offset)
                    .gesture(
                        DragGesture()
                            .onChanged { gesture in
                                // Move the button only within the width of the track
                                if gesture.translation.width > 0, gesture.translation.width <= (buttonWidth - 70) {
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
                                    router.navigateTo(.HomeView)
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

// #Preview {
//    CountdownView()
// }

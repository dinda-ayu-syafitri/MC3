import SwiftData
import SwiftUI

struct SOSView: View {
    @State private var ripple1 = false
    @State private var ripple2 = false
    @State private var ripple3 = false
    @State private var scale: CGFloat = 1.0
    @EnvironmentObject var router: Router

    var body: some View {
        ZStack {
            Color.bg
                .ignoresSafeArea()
            VStack {
                Button(action: {
                    // Action to be performed when the button is tapped
                    router.navigateTo(.CountdownView)
                }, label: {
                    ZStack {
                        // Ripple effect layers with different pink opacities
                        RoundedRectangle(cornerRadius: 20.0)
                            .fill(Color.appPink.opacity(0.4))
                            .frame(width: 334, height: 634)
                            .scaleEffect(ripple1 ? 1.12 : 1.0)
                            .opacity(ripple1 ? 0 : 1)
                            .animation(Animation.easeOut(duration: 1.5).repeatForever(autoreverses: false), value: ripple1)
                            .onAppear {
                                ripple1.toggle()
                            }

                        RoundedRectangle(cornerRadius: 20.0)
                            .fill(Color.appPink.opacity(0.6))
                            .frame(width: 334, height: 634)
                            .scaleEffect(ripple2 ? 1.12 : 1.0)
                            .opacity(ripple2 ? 0 : 1)
                            .animation(Animation.easeOut(duration: 1.5).delay(0.5).repeatForever(autoreverses: false), value: ripple2)
                            .onAppear {
                                ripple2.toggle()
                            }

                        RoundedRectangle(cornerRadius: 20.0)
                            .fill(Color.appPink.opacity(0.8))
                            .frame(width: 334, height: 634)
                            .scaleEffect(ripple3 ? 1.12 : 1.0)
                            .opacity(ripple3 ? 0 : 1)
                            .animation(Animation.easeOut(duration: 1.5).delay(1.0).repeatForever(autoreverses: false), value: ripple3)
                            .onAppear {
                                ripple3.toggle()
                            }

                        // Main rectangle that does not fade out
                        RoundedRectangle(cornerRadius: 20.0)
                            .fill(Gradient(colors: [Color.pinkLinearTopBrand, Color.pinkLinearBottomBrand]))
                            .frame(width: 334, height: 634)

                        // Content inside the main rectangle
                        VStack {
                            Image(systemName: "bell.and.waves.left.and.right.fill")
                                .resizable()
                                .frame(width: 150, height: 100)
                                .foregroundColor(.white)
                                .scaleEffect(scale)
                                .onAppear {
                                    withAnimation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true)) {
                                        scale = 1.05
                                    }
                                }

                            Text("Tap to activate alert")
                                .font(.title2)
                                .bold()
                                .foregroundColor(.white)
                                .padding(.vertical, 10)

                            Text("Emergency alerts and live location will be sent to listed contacts")
                                .font(.callout)
                                .foregroundColor(.white)
                                .padding(.horizontal, 60)
                        }
                    }

                })
            }
        }
    }
}

#Preview {
    SOSView()
}

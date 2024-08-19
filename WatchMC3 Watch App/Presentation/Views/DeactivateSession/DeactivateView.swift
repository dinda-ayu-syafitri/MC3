//
//  DeactivateView.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 18/08/24.
//

import SwiftUI

struct DeactivateView: View {
    @StateObject private var deactivateViewModel = DeactivateViewModel()
    
    var body: some View {
        VStack(spacing: 8) {
            
            VStack {
                // Display message or circles based on the state of PIN entry
                ZStack {
                    Text(deactivateViewModel.pinMessage)
                        .font(.system(size: 13).weight(.semibold))
                        .foregroundColor(deactivateViewModel.isPinCorrect ? .white : .red)
                        .opacity(deactivateViewModel.enteredPin.isEmpty || deactivateViewModel.enteredPin.count == 4 ? 1 : 0)
                    
                    HStack(spacing: 10) {
                        ForEach(0..<4) { index in
                            Circle()
                                .strokeBorder(Color.white, lineWidth: 2)
                                .background(Circle().fill(index < deactivateViewModel.enteredPin.count ? Color.white : Color.clear))
                                .frame(width: 10, height: 10)
                        }
                    }
                    .opacity(deactivateViewModel.enteredPin.isEmpty || deactivateViewModel.enteredPin.count == 4 ? 0 : 1)
                }
                .frame(height: 8) // Fixed height to prevent movement
                .padding(.top, 20)
                .padding(.bottom)
                
                // Display Numbers and delete buttons
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 4), count: 3), spacing: 4) {
                    ForEach(1...9, id: \.self) { number in
                        Button(action: {
                            deactivateViewModel.handlePinEntry("\(number)")
                        }) {
                            Text("\(number)")
                                .frame(width: 50, height: 26)
                                .background(.grey)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        deactivateViewModel.handlePinEntry("0")
                    }) {
                        Text("0")
                            .frame(width: 50, height: 26)
                            .background(.grey)
                            .foregroundColor(.white)
                            .cornerRadius(5)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Button(action: deactivateViewModel.deleteLastDigit) {
                        Image(systemName: "delete.left.fill")
                            .frame(width: 30, height: 26)
                            .foregroundColor(.red)
                            .cornerRadius(5)
                    }
                    .buttonStyle(.plain)
                }
            }
            
            // Display Cancel Button
            Button(action: {
                // Add your cancel action here
            }) {
                Text("Cancel")
                    .font(.system(size: 13).weight(.semibold))
                    .frame(maxWidth: .infinity, maxHeight: 20)
                    .padding(5)
                    .background(Color.red.opacity(0.5))
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .ignoresSafeArea()
        .background(Color.black)
    }
}

#Preview {
    DeactivateView()
}

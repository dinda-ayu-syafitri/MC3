//
//  InputPinComponent.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import SwiftUI

struct InputPinComponent: View {
//    @State private var pin: String = ""
    @Binding var pin: String
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white.opacity(0.0001))
                .onTapGesture {
                    print("closed")
                    isTextFieldFocused = false
                }
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                HStack(spacing: 10) {
                    ForEach(0..<4) { index in
                        PinBox(character: index < pin.count ? String(pin[pin.index(pin.startIndex, offsetBy: index)]) : "")
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    isTextFieldFocused = true
                }
            }
            .padding()
            .background(
                TextField("", text: $pin)
                    .keyboardType(.numberPad)
                    .focused($isTextFieldFocused)
                    .frame(width: 0, height: 0)
                    .opacity(0)
                    .onChange(of: pin) { oldValue, newValue in
                        if newValue.count > 4 {
                            pin = String(newValue.prefix(4))
                        }
                    }
            )
        }
    }
}

struct PinBox: View {
    let character: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(Color.gray, lineWidth: 1)
            .frame(width: 70, height: 70)
            .overlay(
                Text(character)
                    .font(.title)
            )
    }
}

#Preview {
    InputPinComponent(pin: .constant(""))
}

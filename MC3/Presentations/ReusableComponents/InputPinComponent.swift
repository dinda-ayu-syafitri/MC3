//
//  InputPinComponent.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import SwiftUI

struct InputPinComponent: View {
    @Binding var pin: String
    @FocusState private var isFocused: Bool
    let focusedIndex: Int
    
    var body: some View {
        VStack(spacing: 20) {
            HStack(spacing: 10) {
                ForEach(0..<4) { index in
                    PinBox(character: index < pin.count ? String(pin[pin.index(pin.startIndex, offsetBy: index)]) : "", isFocused: index == focusedIndex)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                isFocused = true
            }
        }
        .padding()
        .background(
            TextField("", text: $pin)
                .keyboardType(.numberPad)
                .focused($isFocused)
                .frame(width: 0, height: 0)
                .opacity(0)
                .onChange(of: pin) { old, newValue in
                    if newValue.count > 4 {
                        pin = String(newValue.prefix(4))
                    }
                }
        )
    }
}


struct PinBox: View {
    let character: String
    let isFocused: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(isFocused ? Color.redBrand : Color.gray, lineWidth: 1)
            .frame(width: 70, height: 70)
            .overlay(
                Text(character)
                    .font(.title)
            )
    }
}

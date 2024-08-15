//
//  PinInputView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 15/08/24.
//

import SwiftUI


struct PinInputView: View {
    @State private var pin: String = ""
    @FocusState private var isTextFieldFocused: Bool

    var body: some View {
        VStack(spacing: 20) {
            Text("Enter Personal Pin")
                .font(.headline)
            
            HStack(spacing: 10) {
                ForEach(0..<4) { index in
                    PinBox(character: index < pin.count ? String(pin[pin.index(pin.startIndex, offsetBy: index)]) : "")
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                // Focus the hidden TextField to show the keyboard
                isTextFieldFocused = true
            }
            
            Spacer()
        }
        .padding()
        .background(
            // Hidden TextField to handle the input
            TextField("", text: $pin)
                .keyboardType(.numberPad)
                .focused($isTextFieldFocused)
                .frame(width: 0, height: 0)
                .opacity(0)
        )
    }
}

struct PinBox: View {
    let character: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 5)
            .stroke(Color.gray, lineWidth: 1)
            .frame(width: 50, height: 50)
            .overlay(
                Text(character)
                    .font(.title)
            )
    }
}
#Preview {
    PinInputView()
}

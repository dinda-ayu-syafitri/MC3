//
//  DeactivateView.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import SwiftUI

struct DeactivateView: View {
    @StateObject private var deactivateVM = DependencyInjection.shared.deactivateViewModel()
    @FocusState private var focusedField: FocusedFieldEnum?
    @Binding var isActive: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 120) {
            ZStack(alignment: .center) {
                HStack(alignment: .center) {
                    Text("Deactivate SOS Alert")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.black)
                }
                
                HStack(alignment: .center) {
                    Spacer()
                    
                    Button(action: {
                        print("Cancel")
                        self.isActive = false
                    }, label: {
                        Text("Cancel")
                            .foregroundStyle(.red)
                            .font(.body)
                    })
                }
            }
            .padding(.horizontal, 16)
            
            VStack(alignment: .center, spacing: 8) {
                Text("Enter personal pin to deacticate SOS Alert")
                    .foregroundStyle(.black)
                    .font(.body)
                
                InputPinComponent(pin: $deactivateVM.pin, focusedIndex: focusedField == .deactivatePin ? deactivateVM.pin.count : -1)
                    .focused($focusedField, equals: .deactivatePin)
                
                if (!deactivateVM.pin.isEmpty) {
                    Text(deactivateVM.stringChecked)
                        .font(.caption)
                        .foregroundStyle(deactivateVM.isMatched ? .green : .red)
                }
            }
            
            Spacer()
        }
        .padding(.top, 16)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Spacer()
                    Button("Done") {
                        focusedField = nil
                    }
                }
            }
        }
    }
}

#Preview {
    DeactivateView(isActive: .constant(false))
}

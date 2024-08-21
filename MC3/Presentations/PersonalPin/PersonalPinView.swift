//
//  PersonalPinView.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import SwiftUI

struct PersonalPinView: View {
    @StateObject private var pinVM = DependencyInjection.shared.personalPinViewModel()
    @FocusState private var focusedField: FocusedFieldEnum?

    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 12) {
                Text("Create your personal pin")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.blackBrand)
                
                Text("Personal pin is used to deactivate\nSOS Alert once it is active")
                    .font(.callout)
                    .foregroundStyle(.blackBrand)
                    .multilineTextAlignment(.center)
            }
            .padding(.bottom, 32)
            
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Insert personal pin")
                        .font(.body)
                        .foregroundStyle(.blackBrand)
                        .bold()
                    
                    InputPinComponent(pin: $pinVM.personalPin, focusedIndex: focusedField == .personalPin ? pinVM.personalPin.count : -1)
                        .focused($focusedField, equals: .personalPin)
                        .background(.whiteBrand)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                        )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Verify personal pin")
                        .font(.body)
                        .foregroundStyle(.blackBrand)
                        .bold()
                    
                    InputPinComponent(pin: $pinVM.confirmPersonalPin, focusedIndex: focusedField == .confirmPersonalPin ? pinVM.confirmPersonalPin.count : -1)
                        .focused($focusedField, equals: .confirmPersonalPin)
                        .background(.whiteBrand)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.black.opacity(0.2), lineWidth: 1)
                        )
                }
                
                withAnimation(
                    Animation.bouncy(duration: 1)
                        .repeatCount(1, autoreverses: true)
                ) {
                    VStack {
                        if (!pinVM.confirmPersonalPin.isEmpty) {
                            Text(pinVM.stringCheck)
                                .font(.caption)
                                .foregroundStyle(pinVM.isCorrect ? .green : .red)
                        }
                    }
                }
            }
            
            Spacer()
            
            Button(action: {
                pinVM.saveToUserDefault()
            }, label: {
                Text("Confirm pin")
                    .font(.headline)
                    .foregroundStyle(.whiteBrand)
                    .padding(.vertical, 14)
                    .frame(maxWidth: .infinity)
                    .background(pinVM.isCorrect ? .redBrand : .gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            })
            .disabled(!pinVM.isCorrect)
        }
        .padding(.horizontal, 16)
        .padding(.top, 98)
        .padding(.bottom, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.grayBrand)
        .ignoresSafeArea()
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
    PersonalPinView()
}

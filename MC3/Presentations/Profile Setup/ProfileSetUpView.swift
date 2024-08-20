//
//  ProfileSetUpView.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 19/08/24.
//

import SwiftUI

struct ProfileSetUpView: View {
    @StateObject var profileVM = DependencyInjection.shared.profileSetUpViewModel()
    @FocusState private var isPhoneNumberFocused: Bool
    @FocusState private var isNameFocused: Bool
    
    var body: some View {
        VStack() {
            Text("Create your profile")
                .font(.title2)
                .bold()
                .foregroundColor(.maroonBrand)
                .padding(.bottom, 32)
            
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Name")
                        .font(.body)
                        .bold()
                        .foregroundStyle(.black)
                    
                    TextField("ex. Jane Doe", text: $profileVM.fullName)
                        .font(.body)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .foregroundStyle(.black)
                        .focused($isNameFocused)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Phone Number")
                        .font(.body)
                        .bold()
                        .foregroundStyle(.black)
                    
                    TextField("ex. 6287821285666", text: $profileVM.phoneNumber)
                        .font(.body)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .keyboardType(.phonePad)
                        .foregroundStyle(.black)
                        .focused($isPhoneNumberFocused)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                }
            }
            
            Spacer()
            
            Button(action: {
                Task {
                    await profileVM.submitProfileSetUp()
                }
            }, label: {
                Text("Create profile")
                    .frame(maxWidth: .infinity)
                    .font(.headline)
                    .padding()
                    .background(profileVM.activateSubmit ? Color.maroonBrand : Color.disableButtonBrand)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            })
            .disabled(!profileVM.activateSubmit)
            .padding(.bottom, 40)
        }
        .padding(.horizontal, 32)
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
                        isPhoneNumberFocused = false
                        isNameFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileSetUpView()
}

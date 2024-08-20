//
//  ProfileSetUpView.swift
//  MC3
//
//  Created by Dinda Ayu Syafitri on 19/08/24.
//

import SwiftUI

struct ProfileSetUpView: View {
    @StateObject var profileVM = DependencyInjection.shared.profileSetUpViewModel()

    var body: some View {
        VStack(spacing: 32) {
            Text("Create your Profile")
                .font(.title)
                .bold()
            VStack(spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Name")
                        .bold()
                    TextField("ex. Jane Doe", text: $profileVM.fullName)
                        .textFieldStyle(.roundedBorder)
                }

                VStack(alignment: .leading) {
                    Text("Phone Number")
                        .bold()
                    TextField("ex. 6287821285666", text: $profileVM.phoneNumber)
                        .textFieldStyle(.roundedBorder)
                }
            }
            Spacer()
            Button(action: {
                Task {
                    await profileVM.submitProfileSetUp()
                }
            }, label: {
                Text("Create Profile")
            })
        }
        .padding()
    }
}

#Preview {
    ProfileSetUpView()
}

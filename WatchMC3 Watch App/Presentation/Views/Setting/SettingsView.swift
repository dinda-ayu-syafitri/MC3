//
//  SettingsView.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 16/08/24.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var homeVM: HomeViewModel
    
    @State var hapticIsEnabled = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // SOS State
            HStack {
                Text("SOS Inactive")
                    .onTapGesture {
                        
                    }
                    .font(.system(size: 17) .weight(.semibold))
                    .foregroundColor(.pastelPink)
                    .frame(alignment: .leading)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            // Headline/Regular
            VStack(spacing: 8) {
                Text("Settings")
                    .font(
                        .system(size: 17)
                        .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .top)
                
                // Haptic setting
                HStack(alignment: .center) {
                    Text("Haptic")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .topLeading)

                    Toggle("", isOn: $hapticIsEnabled)
                        .labelsHidden()
                        .padding()
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.grey)
                .cornerRadius(10)
                
                // Automatic tracking setting
                HStack(alignment: .center) {
                    Text("Automatic alert")
                        .font(.system(size: 15))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .topLeading)

                    Toggle("", isOn: $homeVM.isEnableBackgroundDelivery)
                        .labelsHidden()
                        .padding()
                }
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .frame(maxWidth: .infinity, alignment: .center)
                .background(.grey)
                .cornerRadius(10)
            }
            .frame(maxHeight: .infinity, alignment: .topLeading)
        }
        .padding(10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .ignoresSafeArea()
        .navigationTitle("Setting")
    }
}

#Preview {
    SettingsView(homeVM: HomeViewModel())
}

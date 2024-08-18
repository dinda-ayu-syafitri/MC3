//
//  HBJumpView.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 18/08/24.
//

import SwiftUI

struct HBJumpView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            
            ZStack() {
                Circle()
                    .fill(.melonPink)
                    .frame(width: 98, height: 98)
                
                Image(systemName: "waveform.path.ecg")
                    .font(.system(size: 37)
                        .weight(.semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            VStack(spacing: 2) {
                Text("Heartbeat Jump Detected")
                  .font(
                    .system(size: 17)
                      .weight(.medium)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white)
                  .frame(maxWidth: .infinity, alignment: .top)
                
                // SF/Large (40 + 41 + 42mm)/Caption 2
                Text("Pulse")
                    .font(.system(size: 14))
                  .kerning(0.15)
                  .multilineTextAlignment(.center)
                  .foregroundColor(Color(red: 0.13, green: 0.58, blue: 0.98))
                  .frame(maxWidth: .infinity, alignment: .top)
            }
//            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .ignoresSafeArea()
        .background(.black)
    }
}

#Preview {
    HBJumpView()
}

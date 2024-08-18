//
//  TrackingView.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 18/08/24.
//

import SwiftUI

struct TrackingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // SOS State
            HStack {
                Text("SOS Active")
                    .font(.system(size: 17) .weight(.semibold))
                    .foregroundColor(.pastelPink)
                    .frame(alignment: .leading)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            VStack(spacing: 8) {
                //Heading
                Text("Emergency contact is tracking")
                  .font(
                    .system(size: 17)
                      .weight(.semibold)
                  )
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white)
                  .frame(maxWidth: .infinity, alignment: .top)
                
                // Subtitle
                Text("Your emergency contact is currently \ntracking you")
                    .font(.system(size: 16))
                  .multilineTextAlignment(.center)
                  .foregroundColor(.white)
                  .frame(maxWidth: .infinity, alignment: .top)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .ignoresSafeArea()
        .background(LinearGradient(
            gradient: Gradient(colors: [Color(.melonPink), Color(.darkPink)]),
            startPoint: .top,
            endPoint: .bottom
        ))
    }
}

#Preview {
    TrackingView()
}

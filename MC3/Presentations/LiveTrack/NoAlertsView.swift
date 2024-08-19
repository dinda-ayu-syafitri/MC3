//
//  NoAlertsView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 15/08/24.
//

import SwiftUI

struct NoAlertsView: View {
    var body: some View {
        VStack {
            Text("Live Track")
                       .font(.title2)
                       .fontWeight(.bold)
                       .foregroundColor(.red)
                       .padding(.top, 16)
                   VStack {
                       Color.gray
                           .frame(width: 250, height: 250)
                           .cornerRadius(10)
                           .padding()

                       Text("No active alerts")
                           .font(.headline)
                           .fontWeight(.bold)
                           .padding(.top, 8)
                       
                       Text("You will be notified if somebody activated the SOS alert")
                           .font(.subheadline)
                           .foregroundColor(.gray)
                           .multilineTextAlignment(.center)
                           .padding(.horizontal, 32)
                   }
                   .padding(.top, 50)
                   
                   Spacer()
               }
               .background(Color(.systemGray6).ignoresSafeArea())
    }

}


#Preview {
    NoAlertsView()
}

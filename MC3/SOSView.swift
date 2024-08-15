//
//  SOSView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 14/08/24.
//

import SwiftUI

struct SOSView: View {
    var body: some View {
           NavigationView {
               VStack(spacing: 20) {
                   
                   HStack {
                       Text("Current heart rate")
                           .font(.body)
                           .foregroundColor(.gray)
                       Spacer()
                       HStack(spacing: 5) {
                           Image(systemName: "waveform.path.ecg")
                           Text("75 bpm")
                               .font(.body)
                               .foregroundColor(.gray)
                       }
                       .padding(10)
                       .background(Color.gray.opacity(0.1))
                       .cornerRadius(8)
                   }
                   .padding(.horizontal)
                   .padding(.top, 20)
                   
                   Rectangle()
                       .fill(Color.gray.opacity(0.3))
                       .frame(height: 250)
                       .cornerRadius(10)
                       .overlay(
                           VStack {
                               Text("Tap to activate SOS Alert")
                                   .font(.title3)
                                   .fontWeight(.bold)
                                   .foregroundColor(.black)
                               
                               Text("Emergency alerts and live location will be sent to listed contacts")
                                   .font(.body)
                                   .foregroundColor(.gray)
                                   .multilineTextAlignment(.center)
                                   .padding(.top, 5)
                           }
                           .padding()
                       )
                   
                   Spacer()
                   
                   
               }
               .background(Color(.systemGray6))
               .navigationBarHidden(true)
           }
       }
}

#Preview {
    SOSView()
}

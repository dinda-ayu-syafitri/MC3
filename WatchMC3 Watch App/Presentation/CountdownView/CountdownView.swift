//
//  CountdownView.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 15/08/24.
//

import SwiftUI

import SwiftUI

struct CountdownView: View {
//    @ObservedObject var heartRateViewModel: HeartRateViewModel
    
    var body: some View {
        VStack {
            Text("Alerting in")
                .font(.headline)

//            Text("\(heartRateViewModel.timeRemaining)")
//                .font(.largeTitle)
//                .padding()
//            
//            Button("Cancel") {
//                heartRateViewModel.router.navigate(to: .home)
////                heartRateViewModel.stopCountdown()
//            }
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}
  
#Preview {
    CountdownView()
}
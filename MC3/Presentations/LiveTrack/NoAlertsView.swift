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
                       .foregroundColor(.appPinkSecondary)
                       .padding(.top, 16)
                   VStack {
                       ZStack{
                           RoundedRectangle(cornerRadius: 10.0)
                               .stroke(.gray, lineWidth: 1)
                               .fill(Color.white)
                               .frame(width: 350, height: 626)
                               .padding()
                           
                           VStack{
                               Image(systemName: "bell.slash.fill")
                                   .resizable()
                                   .frame(width: 160, height: 160)
                                   .foregroundStyle(Color.appPinkSecondary)
                               Text("No active alerts")
                                   .font(.title2)
                                   .fontWeight(.bold)
                                   .padding(.top, 8)
                               
                               Text("You will be notified if there is an active SOS Alert")
                                   .font(.callout)
                                   .foregroundColor(.black)
                                   .multilineTextAlignment(.center)
                                   .padding(.top, -3)
                                   .padding(.horizontal, 60)
                           }
                           
                       }
                      

                       
                   }
                   
                   
                   Spacer()
               }
               .background(Color(.bg).ignoresSafeArea())
    }

}


#Preview {
    NoAlertsView()
}

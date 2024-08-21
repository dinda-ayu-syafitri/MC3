//
//  OnboardingView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 14/08/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @EnvironmentObject var router: Router

    var body: some View {
        NavigationStack{
            VStack{
                VStack{
                    Text("Automatic Alert System")
                        .font(.title2)
                        .bold()
                        .padding()
                    Text("By monitoring your heart rate through Apple Watch, our app quickly respond to sudden spikes, automatically activating the SOS Alert")
                        .multilineTextAlignment(.center)
                }
                .padding()
                
                Image("onboarding")
                    .resizable()
                    .frame(width: 350, height: 400)
                Spacer()
                VStack{
                    Button {
                        
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 15.0)
                                .frame(width: 350, height: 60)
                                .foregroundStyle(Color.appPink)
                            Text("Give Permission")
                                .foregroundStyle(Color.white)
                                .bold()
                        }
                        .onTapGesture {
                            router.navigateTo(.AddEmergencyContact)
                        }
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Skip for now")
                             .font(.headline)
                             .foregroundColor(Color.appPinkSecondary)
                             .padding()
                             .overlay(
                                RoundedRectangle(cornerRadius: 15.0)
                                     .stroke(Color.appPinkSecondary, lineWidth: 1)
                                     .frame(width: 350, height: 60)
                             )
                             .onTapGesture {
                                 router.navigateTo(.AddEmergencyContact)
                             }
                    }
                }
                
            }
        }
        
        .background(Color(.bg).ignoresSafeArea())
    }
        
}


#Preview {
    OnboardingView()
}

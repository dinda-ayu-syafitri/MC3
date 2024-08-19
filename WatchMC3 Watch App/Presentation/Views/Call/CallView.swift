//
//  CallView.swift
//  WatchMC3 Watch App
//
//  Created by Michelle Chau on 18/08/24.
//

import SwiftUI

struct CallView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            // SOS State
            HStack {
                Text("SOS Active")
                    .font(.system(size: 17) .weight(.semibold))
                    .foregroundColor(.pastelPink)
                    .frame(alignment: .leading)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            VStack(spacing: 54) {
                //Text
                VStack(){
                    // Contact Name
                    Text("Ayah")
                        .font(
                            Font.custom("SF Pro", size: 17)
                                .weight(.semibold)
                        )
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                    
                    // Call Status
                    Text("CALLING...")
                        .font(Font.custom("SF Pro", size: 11))
                        .foregroundColor(.green)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                }
                
                // Call Buttons
                HStack(alignment: .center, spacing: 8) {
                    //Mute Button
                    ZStack() {
                        Circle()
                            .fill(.grey)
                            .frame(width: 35, height: 35)
                        
                        Image(systemName: "mic.slash")
                            .font(.system(size: 19))
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white.opacity(0.3))
                    }
                    
                    //End Button
                    ZStack() {
                        Circle()
                            .fill(.red)
                            .frame(width: 51, height: 51)
                        
                        Image(systemName: "phone.down.fill")
                            .font(.system(size: 28))
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                    }
                    
                    //Option Button
                    ZStack() {
                        Circle()
                            .fill(.grey)
                            .frame(width: 35, height: 35)
                        
                        Image(systemName: "ellipsis")
                            .font(.system(size: 19))
                            .frame(width: 35, height: 35)
                            .foregroundColor(.white)
                    }
                    
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            
        }
        .padding(10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .ignoresSafeArea()
        .background(.black)
        
    }
}

#Preview {
    CallView()
}

//
//  LiveTrackView.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 14/08/24.
//

import SwiftUI

struct LiveTrackView: View {
    var body: some View {
        VStack{
            Text("Live Track")
                .bold()
                .font(.title2)
            
            Spacer().frame(height: 50)
            
            ZStack{
                Rectangle()
                    .frame(width:320, height: 500)
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 20, bottomLeading: 20, bottomTrailing: 20, topTrailing: 20)))
                    .foregroundColor(.gray)
                
                Circle()
                    .frame(width:40, height: 40)
                    .shadow(radius: 10)
                
                    

            }
            .overlay(alignment: .top) {
                ZStack{
                    Rectangle()
                        .frame(width: 300, height: 100)
                        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 20, bottomLeading: 20, bottomTrailing: 20, topTrailing: 20)))
                        .foregroundColor(.white)
                    Text("Current Location")
                }
                .padding()
            }
            
            HStack{
                Circle()
                    .foregroundColor(.white)
                    .frame(width: 50)
                Text("Syafiqah")
                    
                Spacer().frame(width: 100)
                Button {
                    
                } label: {
                    Text("Call")
                }
                .padding()
            }
            .frame(width: 320, height: 70)
            .background(Color.gray)
            .cornerRadius(20)
            
        }
    }
}

#Preview {
    LiveTrackView()
}


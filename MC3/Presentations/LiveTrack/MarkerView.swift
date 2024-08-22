//
//  MarkerView.swift
//  Pulse
//
//  Created by Giventus Marco Victorio Handojo on 22/08/24.
//

import SwiftUI

struct MarkerView: View {
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .stroke(.redBrand, lineWidth: 5)
                    .fill(.clear)
                    .frame(width: 58)
                
                Image("marker")
                    .resizable()
                    .frame(width: 30, height: 30)
                    
            }
            Triangle()
                .fill(Color.redBrand)
                .frame(width: 12, height: 12)
                .offset(y: -9)
            
            Circle()
                .fill(.redBrand)
                .frame(width: 6)
                .offset(y: -15)
        }
        
    }
}

//struct Triangle: Shape {
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//
//        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))
//        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
//        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
//        path.closeSubpath()
//
//        return path
//    }
//}

#Preview {
    MarkerView()
}

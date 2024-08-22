//
//  UserAnnotation.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 19/08/24.
//

import SwiftUI

struct UserAnnotation: View {
    var isOther: Bool = false
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 48, height: 48)
                .foregroundStyle(isOther ? Color.darkPinkBrand.opacity(0.3) : Color.blue.opacity(0.3))
            
            Circle()
                .frame(width: 32, height: 32)
                .foregroundStyle(.white)
            
            Circle()
                .frame(width: 16, height: 16)
                .foregroundStyle(isOther ? Color.darkPinkBrand : Color.blue)
        }
    }
}

#Preview {
    UserAnnotation()
}

//
//  String+Extension.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 21/08/24.
//

import Foundation

extension String {
    func standardizedPhoneNumber() -> String {
        let cleanedPhoneNumber = self.replacingOccurrences(of: " ", with: "")
        
        if cleanedPhoneNumber.hasPrefix("0") {
            return "+62" + cleanedPhoneNumber.dropFirst()
        } else if cleanedPhoneNumber.hasPrefix("62") {
            return "+" + cleanedPhoneNumber
        } else if cleanedPhoneNumber.hasPrefix("+62") {
            return cleanedPhoneNumber
        } else {
            return cleanedPhoneNumber
        }
    }
}

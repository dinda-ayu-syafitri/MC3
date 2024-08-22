//
//  NumberFormatHelper.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import Foundation

class NumberFormatHelper {
    static func formatNumber(_ number: String) -> String {
        let cleanNumber = number.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        guard let numberValue = Int(cleanNumber) else { return number }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: numberValue)) ?? number
    }
}

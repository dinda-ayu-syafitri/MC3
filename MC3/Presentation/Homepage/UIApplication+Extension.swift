//
//  UIApplication+Extension.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 11/08/24.
//

import SwiftUI

extension UIApplication {
    func rootController() -> UIViewController {
        guard let window = connectedScenes.first as? UIWindowScene else { return .init() }
        guard let viewController = window.windows.last?.rootViewController else { return .init() }
        
        return viewController
    }
}

//
//  OnboardingViewWrapper.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 20/08/24.
//

import SwiftUI
import UIKit

struct OnboardingViewWrapper: UIViewControllerRepresentable {
    @EnvironmentObject var router: Router  // Use EnvironmentObject

    func makeUIViewController(context: Context) -> OnboardingViewController {
        let onboardingVC = OnboardingViewController()
        onboardingVC.router = router
        return onboardingVC
    }

    func updateUIViewController(_ uiViewController: OnboardingViewController, context: Context) {
        // No need to update the view controller in this simple case
    }
}


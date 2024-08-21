//
//  OnboardingViewController.swift
//  MC3
//
//  Created by Giventus Marco Victorio Handojo on 20/08/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var router: Router?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(named: "bg")
        
        // Title label
        let titleLabel = UILabel()
        titleLabel.text = "Automatic Alert System"
        titleLabel.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Description label
        let descriptionLabel = UILabel()
        descriptionLabel.text = "By monitoring your heart rate through Apple Watch, our app quickly responds to sudden spikes, automatically activating the SOS Alert"
        descriptionLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Onboarding image
        let onboardingImageView = UIImageView(image: UIImage(named: "onboarding"))
        onboardingImageView.contentMode = .scaleAspectFit
        onboardingImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Permission button
        let permissionButton = UIButton(type: .system)
        permissionButton.setTitle("Give Permission", for: .normal)
        permissionButton.setTitleColor(.white, for: .normal)
        permissionButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        permissionButton.backgroundColor = UIColor(named: "appPink")
        permissionButton.layer.cornerRadius = 15
        permissionButton.translatesAutoresizingMaskIntoConstraints = false
        permissionButton.addTarget(self, action: #selector(permissionButtonTapped), for: .touchUpInside)
        
        // Skip button
        let skipButton = UIButton(type: .system)
        skipButton.setTitle("Skip for now", for: .normal)
        skipButton.setTitleColor(UIColor(named: "appPinkSecondary"), for: .normal)
        skipButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        skipButton.layer.cornerRadius = 15
        skipButton.layer.borderWidth = 1
        skipButton.layer.borderColor = UIColor(named: "appPinkSecondary")?.cgColor
        skipButton.translatesAutoresizingMaskIntoConstraints = false
        skipButton.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        
        // Add subviews
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(onboardingImageView)
        view.addSubview(permissionButton)
        view.addSubview(skipButton)
        
        // Layout constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            onboardingImageView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            onboardingImageView.widthAnchor.constraint(equalToConstant: 350),
            onboardingImageView.heightAnchor.constraint(equalToConstant: 400),
            onboardingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            permissionButton.topAnchor.constraint(equalTo: onboardingImageView.bottomAnchor, constant: 30),
            permissionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            permissionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            permissionButton.heightAnchor.constraint(equalToConstant: 60),
            
            skipButton.topAnchor.constraint(equalTo: permissionButton.bottomAnchor, constant: 20),
            skipButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            skipButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc func permissionButtonTapped() {
        router?.navigateTo(.AddEmergencyContact)
    }
    
    @objc func skipButtonTapped() {
        router?.navigateTo(.AddEmergencyContact)
    }
}


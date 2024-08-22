//
//  ProfileViewModel.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 22/08/24.
//

import Foundation
import FirebaseAuth
import AuthenticationServices
import GoogleSignIn

class ProfileViewModel: ObservableObject {
    @Published var enableAlertSound = true
    @Published var enableHaptic = true
    @Published var enableAutomaticAlert = true
    @Published var isPickerExpanded = false
    @Published var selectedDelayTime = 5
    let delayTimes = Array(1...10) // Range from 1 to 10 seconds
    
    func logOut() {
        do {
            try Auth.auth().signOut()
            print("Successfully signed out from Firebase")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        // Log out from Apple Sign-In
        if let appleProvider = Auth.auth().currentUser?.providerData.first(where: { $0.providerID == "apple.com" }) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            appleIDProvider.getCredentialState(forUserID: appleProvider.uid) { (credentialState, error) in
                switch credentialState {
                case .revoked:
                    print("Apple ID credential revoked")
                case .notFound:
                    print("Apple ID credential not found")
                case .authorized:
                    // Remove any locally stored Apple ID credentials if necessary
                    print("Apple ID credential authorized, performing sign out")
                default:
                    break
                }
            }
        }
        
        // Log out from Google Sign-In
        GIDSignIn.sharedInstance.signOut()
        print("Successfully signed out from Google")
        
        // Clear stored user data
        UserDefaults.standard.removeObject(forKey: KeyUserDefaultEnum.idFirebase.toString)
        UserDefaults.standard.removeObject(forKey: KeyUserDefaultEnum.email.toString)
        UserDefaults.standard.removeObject(forKey: KeyUserDefaultEnum.statusBoarding.toString)
        
        print("User data cleared")
    }
}

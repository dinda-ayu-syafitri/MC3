//
//  UserDefaultUseCaseProtocol.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import Foundation

protocol UserDefaultUseCaseProtocol {
    func saveLoginData(email: String, firebaseID: String)
    func clearDataWhenLogOut(email: String, firebaseID: String)
}

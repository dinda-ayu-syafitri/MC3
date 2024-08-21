//
//  UserDefaultUseCaseProtocol.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import Foundation

protocol UserDefaultUseCaseProtocol {
    func saveLoginData(email: String, firebaseID: String)
    func saveProfileData(fullName: String, phoneNumber: String)
    func clearDataWhenLogOut(email: String, firebaseID: String)
    func saveData(data: Any, key: KeyUserDefaultEnum)
    func getData(key: KeyUserDefaultEnum) -> Any?
//    func saveProfileData(fullName: String, phoneNumber: String)
}


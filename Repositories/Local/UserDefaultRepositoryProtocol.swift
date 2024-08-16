//
//  UserDefaultRepositoryProtocol.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import Foundation

protocol UserDefaultRepositoryProtocol {
    func saveData(data: Any, key: KeyUserDefaultEnum)
    func getData(key: KeyUserDefaultEnum) -> Any?
    func deleteData(key: KeyUserDefaultEnum)
}

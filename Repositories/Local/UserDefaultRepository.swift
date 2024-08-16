//
//  UserDefaultRepository.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import Foundation

class UserDefaultRepository: UserDefaultRepositoryProtocol {
    private var userDefaultDataSource: UserDefaultDataSourceProtocol
    init(userDefaultDataSource: UserDefaultDataSourceProtocol) {
        self.userDefaultDataSource = userDefaultDataSource
    }
    
    func saveData(data: Any, key: KeyUserDefaultEnum) {
        userDefaultDataSource.saveData(data: data, key: key)
    }
    
    func getData(key: KeyUserDefaultEnum) -> Any? {
        userDefaultDataSource.getData(key: key)
    }
    
    func deleteData(key: KeyUserDefaultEnum) {
        userDefaultDataSource.deleteData(key: key)
    }
}

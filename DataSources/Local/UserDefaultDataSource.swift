//
//  UserDefaultDataSource.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import Foundation

class UserDefaultDataSource: UserDefaultDataSourceProtocol {
    let userDefaults = UserDefaults.standard
    
    func saveData(data: Any, key: KeyUserDefaultEnum) {
        userDefaults.set(data, forKey: key.toString)
    }
    
    func getData(key: KeyUserDefaultEnum) -> Any? {
        if let stringValue = userDefaults.string(forKey: key.toString) {
            return stringValue
        } else if userDefaults.object(forKey: key.toString) is Bool {
            return userDefaults.bool(forKey: key.toString)
        } else if userDefaults.object(forKey: key.toString) is Int {
            return userDefaults.integer(forKey: key.toString)
        } else if userDefaults.object(forKey: key.toString) is Double {
            return userDefaults.double(forKey: key.toString)
        } else if userDefaults.object(forKey: key.toString) is Float {
            return userDefaults.float(forKey: key.toString)
        } else if let arrayValue = userDefaults.array(forKey: key.toString) {
            return arrayValue
        } else if let dictionaryValue = userDefaults.dictionary(forKey: key.toString) {
            return dictionaryValue
        } else {
            return nil
        }
    }

    func deleteData(key: KeyUserDefaultEnum) {
        userDefaults.removeObject(forKey: key.toString)
    }
}

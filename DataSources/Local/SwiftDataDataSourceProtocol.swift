//
//  SwiftDataDataSourceProtocol.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import Foundation

protocol SwiftDataDataSourceProtocol {
    func getUser() async throws -> User
    func registerUser(user: User) async throws
    func deleteUser(user: User) async throws
    func updateUser(user: User) async throws
}


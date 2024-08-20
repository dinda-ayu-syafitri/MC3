//
//  FirebaseServiceRepository.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 14/08/24.
//

import Foundation

class FirebaseServiceRepository: FirebaseServiceRepositoryProtocol {
    private let firebaseServiceDataSource: FirebaseServiceDataSourceProtocol
    
    init(firebaseServiceDataSource: FirebaseServiceDataSourceProtocol) {
        self.firebaseServiceDataSource = firebaseServiceDataSource
    }
    
    func submitDataWithIDFirebase(idFirestore: String, data: [String : Any]) async throws {
        try await firebaseServiceDataSource.submitDataWithIDFirebase(idFirestore: idFirestore, data: data)
    }
    
    func updateDataWithIDFirebase(idFirestore: String, data: [String: Any]) async throws {
        try await firebaseServiceDataSource.updateDataWithIDFirebase(idFirestore: idFirestore, data: data)
    }
}

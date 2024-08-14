//
//  FirebaseServiceDataSource.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 14/08/24.
//

import Foundation
import FirebaseFirestore

class FirebaseServiceDataSource: FirebaseServiceDataSourceProtocol {
    private let db = Firestore.firestore()
    
    func submitDataWithIDFirebase(idFirestore: String, data: [String : Any]) async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            db.collection("User").document(idFirestore).setData(data) { error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: ())
                }
            }
        }
    }
}

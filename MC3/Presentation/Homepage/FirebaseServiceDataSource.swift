//
//  FirebaseServiceDataSource.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 14/08/24.
//

import FirebaseFirestore
import Foundation

class FirebaseServiceDataSource: FirebaseServiceDataSourceProtocol {
    private let db = Firestore.firestore()

    func submitDataWithIDFirebase(idFirestore: String, data: [String: Any]) async throws {
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

    func updateDataWithIDFirebase(idFirestore: String, data: [String: Any]) async throws {
        let documentRef = db.collection("User").document(idFirestore)
        try await documentRef.updateData(data)
    }

    func fetchUsers() async throws -> [QueryDocumentSnapshot] {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<[QueryDocumentSnapshot], Error>) in
            db.collection("User").getDocuments { snapshot, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let snapshot = snapshot {
                    continuation.resume(returning: snapshot.documents)
                } else {
                    continuation.resume(throwing: NSError(domain: "FirestoreError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Unknown error occurred"]))
                }
            }
        }
    }

    func fetchFCMKey(for phoneNumber: String) async throws -> String? {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<String?, Error>) in
            db.collection("User").whereField("phoneNumber", isEqualTo: phoneNumber).getDocuments { snapshot, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let document = snapshot?.documents.first {
                    let fcmKey = document.data()["fcm"] as? String
                    continuation.resume(returning: fcmKey)
                } else {
                    continuation.resume(returning: nil)
                }
            }
        }
    }
}

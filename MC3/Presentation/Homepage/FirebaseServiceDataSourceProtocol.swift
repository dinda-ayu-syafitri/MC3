//
//  FirestoreDataSourceProtocol.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 14/08/24.
//

import Foundation

protocol FirebaseServiceDataSourceProtocol {
    func submitDataWithIDFirebase(idFirestore: String, data: [String: Any]) async throws
    func updateDataWithIDFirebase(idFirestore: String, data: [String: Any]) async throws
}

//
//  MKCoordinateRegion.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import Foundation
import MapKit

extension MKCoordinateRegion {
    static var userRegion: MKCoordinateRegion {
        return .init(
            center: .userLoct,
            latitudinalMeters: 1000,
            longitudinalMeters: 1000
        )
    }
}

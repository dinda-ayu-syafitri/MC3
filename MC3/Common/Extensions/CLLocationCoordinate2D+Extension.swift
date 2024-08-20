//
//  CLLocationCoordinate2D.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 15/08/24.
//

import Foundation
import MapKit
import CoreLocation

extension CLLocationCoordinate2D {
    static var userLoct: CLLocationCoordinate2D {
        return .init(
            latitude: -6.303338,
            longitude: 106.638168
        )
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

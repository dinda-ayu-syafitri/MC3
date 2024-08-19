//
//  LocationManagerViewModel.swift
//  MC3
//
//  Created by Luthfi Misbachul Munir on 13/08/24.
//

import Foundation
import MapKit
import CoreLocation

class LocationManagerViewModel: NSObject, ObservableObject, MKMapViewDelegate, CLLocationManagerDelegate {
    @Published var manager: CLLocationManager = .init()
    @Published var userLocation: CLLocationCoordinate2D = .init(latitude: -6.303338, longitude: 106.638168)
    @Published var isLocationAuthorized: Bool = false
    
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let currentLocation = locations.last else{return}
        userLocation = currentLocation.coordinate
        isLocationAuthorized = true
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        checkAuthorization()
    }
    
    func checkAuthorization(){
        switch manager.authorizationStatus {
        case .notDetermined:
            print("Location is not determined")
            manager.requestWhenInUseAuthorization()
        case .denied:
            print("Location is denied")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location permission done")
            manager.requestLocation()
        default:
            break;
        }
    }
    
    func getPlaceName(coordinate: CLLocationCoordinate2D, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error in reverse geocoding: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?.first else {
                completion(nil)
                return
            }
            
            let name = placemark.name ?? "Unknown location"
            completion(name)
        }
    }
    
    func refreshLocation() {
        manager.requestLocation()
    }
}

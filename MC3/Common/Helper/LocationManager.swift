//
//  LocationManager.swift
//  Pulse
//
//  Created by Luthfi Misbachul Munir on 20/08/24.
//

import Foundation
import CoreLocation
import UIKit

final class LocationManager: NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var lastKnownLocation: CLLocationCoordinate2D?
    @Published var userAcceptLocation: Bool = false {
        didSet {
            self.alertingAlwaysUseLocation = self.userAcceptLocation
        }
    }
    @Published var alertingAlwaysUseLocation: Bool = false
    var manager = CLLocationManager()
    
    override init() {
        super.init()
        manager.delegate = self
        manager.allowsBackgroundLocationUpdates = true
        manager.pausesLocationUpdatesAutomatically = false
    }
    
    func checkLocationAuthorization() {
        manager.delegate = self
        manager.startUpdatingLocation()
        
        switch manager.authorizationStatus {
        case .notDetermined://The user choose allow or denny your app to get the location yet
            manager.requestAlwaysAuthorization()
            //            alertingAlwaysUseLocation = true
            print("Location not determined")
            //            manager.requestWhenInUseAuthorization()
            
        case .restricted://The user cannot change this app’s status, possibly due to active restrictions such as parental controls being in place.
            print("Location restricted")
            DispatchQueue.main.async {
                self.alertUserToGoToSettings()
            }
            
        case .denied://The user dennied your app to get location or disabled the services location or the phone is in airplane mode
            print("Location denied")
            DispatchQueue.main.async {
                self.alertUserToGoToSettings()
            }
            
        case .authorizedAlways://This authorization allows you to use all location services and receive location events whether or not your app is in use.
            print("Location authorizedAlways")
            self.userAcceptLocation = true
            lastKnownLocation = manager.location?.coordinate
            
        case .authorizedWhenInUse://This authorization allows you to use all location services and receive location events only when your app is in use
            print("Location authorized when in use")
            self.userAcceptLocation = true
            manager.requestAlwaysAuthorization()
            
        @unknown default:
            print("Location service disabled")
            
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {//Trigged every time authorization status changes
        checkLocationAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
    
    private func alertUserToGoToSettings() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.manager.authorizationStatus == .restricted || self.manager.authorizationStatus == .denied {
                self.alertingAlwaysUseLocation = true
            }
        }
    }
}

//
//  LocationManager.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 12/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationManagerDelegate {
    func didDetectCurrentUserLocation(location: CLLocation)
    func userLocationDenied()
}
class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    var delegate: LocationManagerDelegate?
    
    func initService() {
        if locationServiceAvailable() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        } else {
            if let delegate = self.delegate {
                delegate.userLocationDenied()
            }
        }
    }
    
    private func locationServiceAvailable() -> Bool {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways, .notDetermined:
            print("authorizedWhenInUse")
            return true
            
        case .denied, .restricted:
            print("not allowed!!")
            return false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.locationManager.stopUpdatingLocation()
            if let delegate = self.delegate {
                delegate.didDetectCurrentUserLocation(location: location)
            }
        }
    }
}

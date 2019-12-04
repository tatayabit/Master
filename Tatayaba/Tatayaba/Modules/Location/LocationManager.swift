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
    func userLocationEnabled()
}
class LocationManager: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    
    var delegate: LocationManagerDelegate?
    
    func initService() {
        locationManager.delegate = self
        if locationServiceAvailable() {
            if self.locationServiceEnabled() {
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.distanceFilter = kCLLocationAccuracyHundredMeters
                locationManager.startUpdatingLocation()
            } else {
                locationManager.requestWhenInUseAuthorization()
            }
            
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
    
    private func locationServiceEnabled() -> Bool {
        return CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.locationManager.stopUpdatingLocation()
            if let delegate = self.delegate {
                delegate.didDetectCurrentUserLocation(location: location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            if let delegate = self.delegate {
                delegate.userLocationEnabled()
            }
        
        case .denied:
            if let delegate = self.delegate {
                delegate.userLocationDenied()
            }
        default:
            break
        }
    }
}

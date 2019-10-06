//
//  ReverseGeoCoder.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/6/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import CoreLocation

class ReverseGeoCoder {
    // MARK: - Properties
    lazy var geocoder = CLGeocoder()
    
    func getCountry(lat: Double, lng: Double, complete: ((String, Error?) -> ())?) {
        let location = CLLocation(latitude: lat, longitude: lng)
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // Process Response
            let result = self.processResponse(withPlacemarks: placemarks, error: error)
            
            if let complete = complete {
                complete(result.0, result.1)
            }
        }
    }
    
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) -> (String, Error?) {
        
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
            return ("", error)
        }
        
        if let placemarks = placemarks, let placemark = placemarks.first {
            if let country = placemark.country {
                return (country, nil)
            }
            let error = NSError(domain: "No Matching Addresses Found", code: 401, userInfo: [ NSLocalizedDescriptionKey: "No Matching Addresses Found"])
            return ("", error)
        } else {
            let error = NSError(domain: "No Matching Addresses Found", code: 401, userInfo: [ NSLocalizedDescriptionKey: "No Matching Addresses Found"])
            return ("", error)
        }
    }
}

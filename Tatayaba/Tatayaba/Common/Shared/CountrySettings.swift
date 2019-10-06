//
//  CountrySettings.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/6/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

class CountrySettings {
    static let shared = CountrySettings()
    var reversedCountryName: String?
    
    func getGeoReversedCountry() {
        let geoCoder = ReverseGeoCoder()
        geoCoder.getCountry(lat: 29.3571553, lng: 47.9945803) { (countryName, error) in
            if error != nil {
                self.reversedCountryName = "Kuwait"
                return
            }
            self.reversedCountryName = countryName
        }
    }
}

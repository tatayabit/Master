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
    var paymentMethods: [PaymentMethod]?
    var shipping : Shipping?
    var tax : Tax?
    
    
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
    
    func updatePaymentsMethods(list: [PaymentMethod]) {
        self.paymentMethods = list
    }
    
    func updateShipping(shippingValue: Shipping) {
        self.shipping = shippingValue
    }
    
    func updateTax(taxValue: Tax) {
        self.tax = taxValue
    }
}

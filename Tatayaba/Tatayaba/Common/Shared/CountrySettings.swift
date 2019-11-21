//
//  CountrySettings.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/6/19.
//  Copyright © 2019 Shaik. All rights reserved.
//
import SwiftKeychainWrapper

protocol CountrySettingsDelegate: class {
    func countryDidChange(to country: Country)
}


class CountrySettings {
    let countrySettingsDataKey = "countrySettingsDataKey"

    static let shared = CountrySettings()
    var currentCountry: Country? {
        willSet {
            Cart.shared.reset()
            if let currentCountry = newValue {
                saveCountrySettingsDataToKeyChain(countryObj: currentCountry)
                for delegate in delegates {
                    delegate.countryDidChange(to: currentCountry)
                }
            }
        }
    }
    
    var paymentMethods: [PaymentMethod]?
    var shipping : Shipping?
    var tax : Tax?
    
    private var delegates = [CountrySettingsDelegate]()
    
    
    func getGeoReversedCountry() {
        let geoCoder = ReverseGeoCoder()
        geoCoder.getCountry(lat: 29.3571553, lng: 47.9945803) { (countryName, error) in
            if error != nil {
                self.currentCountry = CountriesManager.shared.country(with: countryName)//"Kuwait"
                return
            }
            self.currentCountry = CountriesManager.shared.country(with: countryName)
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
    
    // MARK:- Delegate
    func addDelegate(delegate: CountrySettingsDelegate) {
        self.delegates.append(delegate)
    }
    
    //MARK:- Load Data From KeyChain
    func loadData() {
        loadCountrySettingsDataFromKeyChain()
        if currentCountry == nil {
            self.getGeoReversedCountry()
        }
    }
    
    //MARK:- UserData KeyChain
    private func saveCountrySettingsDataToKeyChain(countryObj: Country) {
        let data = try? PropertyListEncoder().encode(countryObj)
        guard let dataX = data else { return }
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: dataX)
        let saved = KeychainWrapper.standard.set(encodedData, forKey: countrySettingsDataKey)
        print("saved: \(saved)")
    }

    private func loadCountrySettingsDataFromKeyChain() {
        guard let savedData = KeychainWrapper.standard.data(forKey: countrySettingsDataKey) else { return }
        guard let encodedData = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? Data else { return }

        let countrySettingsDataDecoded = try? PropertyListDecoder().decode(Country.self, from: encodedData)
        currentCountry = countrySettingsDataDecoded
        print("loaded CountrySettingsData: \(String(describing: currentCountry))")
    }
}

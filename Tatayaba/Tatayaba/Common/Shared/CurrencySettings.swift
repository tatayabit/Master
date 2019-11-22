//
//  CountrySettings.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/6/19.
//  Copyright © 2019 Shaik. All rights reserved.
//
import SwiftKeychainWrapper

protocol CurrencySettingsDelegate: class {
    func currencyDidChange(to currency: Currency)
}


class CurrencySettings {
    let currencySettingsDataKey = "currencySettingsDataKey"

    static let shared = CurrencySettings()
    var currentCurrency: Currency? {
        willSet {
            if let updatedCurrency = newValue {
                saveCurrencySettingsDataToKeyChain(currencyObj: updatedCurrency)
                for delegate in delegates {
                    delegate.currencyDidChange(to: updatedCurrency)
                }
            }
        }
    }
    
    var kuwaitiDinarCurrency: Currency?
    
    private var delegates = [CurrencySettingsDelegate]()
    
    // MARK:- Delegate
    func addCurrencyDelegate(delegate: CurrencySettingsDelegate) {
        self.delegates.append(delegate)
    }
    
    //MARK:- Load Data From KeyChain
    func loadData() {
        loadCurrencySettingsDataFromKeyChain()
        if currentCurrency == nil {
            CurrenciesManager.shared.loadCurrenciesList()
        }
    }
    
    //MARK:- UserData KeyChain
    private func saveCurrencySettingsDataToKeyChain(currencyObj: Currency) {
        let data = try? PropertyListEncoder().encode(currencyObj)
        guard let dataX = data else { return }
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: dataX)
        let saved = KeychainWrapper.standard.set(encodedData, forKey: currencySettingsDataKey)
        print("saved: \(saved)")
    }

    private func loadCurrencySettingsDataFromKeyChain() {
        guard let savedData = KeychainWrapper.standard.data(forKey: currencySettingsDataKey) else { return }
        guard let encodedData = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? Data else { return }

        let currencySettingsDataDecoded = try? PropertyListDecoder().decode(Currency.self, from: encodedData)
        self.currentCurrency = currencySettingsDataDecoded
        print("loaded CurrencySettingsData: \(String(describing: currentCurrency))")
    }
}

extension Constants {
    struct Currency {
        static let kuwaitCurrencyId = "4"
    }
}

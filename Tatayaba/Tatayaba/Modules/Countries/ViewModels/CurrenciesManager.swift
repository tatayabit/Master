//
//  CountriesManager.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/18/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation
import Moya


class CurrenciesManager {
    var currenciesList = [Currency]()
    let apiClient = CurrencyAPIClient()
    static let shared = CurrenciesManager()
    
    //MARK:- Api
    func loadCurrenciesList() {
        if currenciesList.count > 0 { return }
        
        apiClient.getCurrencies { result in
            switch result {
            case .success(let response):
                guard let currenciesResult = response else { return }
                self.currenciesList = currenciesResult
                self.setKuwaitiDinarCurrency()
            
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    func setKuwaitiDinarCurrency() {
        for currency in self.currenciesList {
            if currency.currencyId == Constants.Currency.kuwaitCurrencyId {
                CurrencySettings.shared.kuwaitiDinarCurrency = currency
                break
            }
        }
    }
}

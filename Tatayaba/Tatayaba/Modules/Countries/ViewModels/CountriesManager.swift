//
//  CountriesManager.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/18/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation
import Moya


class CountriesManager {
    var countriesList = [Country]()
    let apiClient = CountriesAPIClient()
    static let shared = CountriesManager()
    
    //MARK:- Api
    func loadCountriesList() {
        if countriesList.count > 0 { return }
        
        apiClient.getCountries { result in
            switch result {
            case .success(let response):
                guard let countriesResult = response else { return }
                self.countriesList = countriesResult.sorted(by: { $0.name < $1.name })
            
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    func country(at indexPath: IndexPath) -> Country {
        guard countriesList.count > 0 else { return Country() }
        return countriesList[indexPath.row]
    }
    
    func country(with name: String) -> Country? {
        let foundCountries = self.countriesList.filter({ $0.name == name })
        if foundCountries.count > 0 {
            return foundCountries.first
        }
        return nil
    }
    
    func checkCountryAvailability(with name: String) -> Bool{
        let foundCountries = self.countriesList.filter({ $0.name == name })
               if foundCountries.count > 0 {
                   return true
               }else{
                return false
        }
    }
    
}

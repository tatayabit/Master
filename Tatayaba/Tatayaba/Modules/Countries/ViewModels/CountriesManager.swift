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
                self.countriesList = countriesResult
            
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    func country(at indexPath: IndexPath) -> Country {
        guard countriesList.count > 0 else { return Country() }
        return countriesList[indexPath.row]
    }
}

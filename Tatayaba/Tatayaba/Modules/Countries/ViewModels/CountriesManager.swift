//
//  CountriesManager.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/18/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation
 private var countryList = [Country]()

struct CountriesManager {
    static let countriesJsonFile = "countries_list"
    static func loadCountriesList() -> [Country] {
        let url = Bundle.main.url(forResource: countriesJsonFile, withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            // the name data is misleading
            let myStruct = try decoder.decode([Country].self, from: jsonData)
            
            return myStruct

        } catch { print(error) }
        return [Country(code: "KW", name: "Kuwait")]
    }
    
    
    func country(at indexPath: IndexPath) -> Country {
        guard countryList.count > 0 else { return Country() }
        return countryList[indexPath.row]
    }
    
}

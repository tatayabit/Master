//
//  CountriesManager.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/18/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct CountriesManager {
    static let countriesJsonFile = "countries_list"
    static func loadCountriesList() {
        let url = Bundle.main.url(forResource: countriesJsonFile, withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            // the name data is misleading
            let myStruct = try decoder.decode([Country].self, from: jsonData)
//            print(myStruct)

        } catch { print(error) }
    }
}

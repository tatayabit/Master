//
//  CountryViewController.swift
//  Tatayaba
//
//  Created by Maheep on 25/09/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol CountryViewDelegate: class {
    func countrySelected(selectedCountry: Country)
}

protocol CurrencyViewDelegate: class {
    func currencySelected(selectedCurrency: Currency)
}

class CountryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    private let viewModel = CountriesManager()
    private let currencyViewModel = CurrenciesManager()
    let encoder = JSONEncoder()
    let countriesList = CountriesManager.shared.countriesList
    let currenciesList = CurrenciesManager.shared.currenciesList
    weak var delegate: CountryViewDelegate?
    weak var currencyDelegate: CurrencyViewDelegate?
    var viewType: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewType == 0 {
            print(countriesList)
        } else {
            print(currenciesList)
        }
        NavigationBarWithBackButton()
        
    }
    
    
}
extension CountryViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewType == 0 {
            return countriesList.count
        } else {
            return currenciesList.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CountryTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountryTableViewCell
//        cell.country_lbl.text = countriesList[indexPath.row].name
        //  cell.code_lbl.text = ListCountrys[indexPath.row].code
        if viewType == 0 {
            cell.configure(country: countriesList[indexPath.row])
        } else {
            cell.configureCurrency(currency: currenciesList[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if viewType == 0 {
            delegate?.countrySelected(selectedCountry: countriesList[indexPath.row])
            if let currency = currenciesList.first(where: {$0.countriesList.contains(countriesList[indexPath.row].code)}){
                CurrencySettings.shared.currentCurrency = currency
                if let encoded = try? encoder.encode(countriesList[indexPath.row]) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "country")
                }
                if let encoded = try? encoder.encode(currency) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "currency")
                }
            }
            if Customer.shared.loggedin {
                Customer.shared.removeAddressData()
            }
            navigateToHome()
//            navigationController?.popViewController(animated: true)
        } else {
            CurrencySettings.shared.currentCurrency = currenciesList[indexPath.row]
            if let encoded = try? encoder.encode(currenciesList[indexPath.row]) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "currency")
            }
            navigateToHome()
        }
    }
}

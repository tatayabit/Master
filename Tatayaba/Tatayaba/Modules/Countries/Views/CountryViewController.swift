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
    func currencySelected(selectedCurrency: Country)
}

class CountryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    private let viewModel = CountriesManager()
    let countriesList = CountriesManager.shared.countriesList
    weak var delegate: CountryViewDelegate?
    weak var currencyDelegate: CurrencyViewDelegate?
    var viewType: Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if viewType == 0 {
            print(countriesList)
        } else {
            
        }
        NavigationBarWithBackButton()
    }
    
    
}
extension CountryViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewType == 0 {
            return countriesList.count
        } else {
            return countriesList.count
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
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if viewType == 0 {
            delegate?.countrySelected(selectedCountry: countriesList[indexPath.row])
        } else {
            currencyDelegate?.currencySelected(selectedCurrency: countriesList[indexPath.row])
        }
        navigationController?.popViewController(animated: true)
    }
}

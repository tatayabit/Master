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

class CountryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    private let viewModel = CountriesManager()
    let countriesList = CountriesManager.shared.countriesList
    weak var delegate: CountryViewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(countriesList)
        
        self.NavigationBarWithBackButton()
    }
    
    
}
extension CountryViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.countriesList.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CountryTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountryTableViewCell
//        cell.country_lbl.text = countriesList[indexPath.row].name
        //  cell.code_lbl.text = ListCountrys[indexPath.row].code
        cell.configure(country: countriesList[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.countrySelected(selectedCountry: countriesList[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

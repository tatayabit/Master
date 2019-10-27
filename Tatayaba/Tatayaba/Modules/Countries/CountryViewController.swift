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
    let ListCountrys = CountriesManager.loadCountriesList()
    weak var delegate: CountryViewDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(ListCountrys)
        
        self.NavigationBarWithBackButton()
    }
    
    
}
extension CountryViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.ListCountrys.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CountryTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CountryTableViewCell
        cell.country_lbl.text = ListCountrys[indexPath.row].name
        //  cell.code_lbl.text = ListCountrys[indexPath.row].code
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.countrySelected(selectedCountry: ListCountrys[indexPath.row])
        navigationController?.popViewController(animated: true)
    }
}

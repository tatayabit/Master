//
//  CountryTableViewCell.swift
//  Tatayaba
//
//  Created by Maheep on 25/09/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CountryTableViewCell: UITableViewCell {

    @IBOutlet weak var code_lbl: UILabel!
    @IBOutlet weak var country_lbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(country: Country) {
        self.country_lbl.text = country.name
        if let selectedCountry = CountrySettings.shared.currentCountry {
            if selectedCountry.name.lowercased() == country.name.lowercased() {
                self.country_lbl.font = UIFont.boldSystemFont(ofSize: 18)
                self.isUserInteractionEnabled = false
            } else {
                self.country_lbl.font = UIFont.systemFont(ofSize: 17)
            }
        } else {
            self.country_lbl.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    func configureCurrency(currency: Currency) {
        self.country_lbl.text = currency.currencyCode
        if let selectedCurrency = CurrencySettings.shared.currentCurrency {
            if selectedCurrency.descriptionField.lowercased() == currency.descriptionField.lowercased() {
                self.country_lbl.font = UIFont.boldSystemFont(ofSize: 18)
            } else {
                self.country_lbl.font = UIFont.systemFont(ofSize: 17)
            }
        } else {
            self.country_lbl.font = UIFont.systemFont(ofSize: 17)
        }
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

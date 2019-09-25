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
        
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

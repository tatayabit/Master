//
//  PriceTableViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/10/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class PriceTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(title: String, value: String) {
        self.titleLabel.text = title
        self.valueLabel.text = value
    }
    
}

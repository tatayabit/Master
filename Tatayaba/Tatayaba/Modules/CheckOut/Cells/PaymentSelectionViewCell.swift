//
//  PaymentSelectionViewCell.swift
//  Tatayaba
//
//  Created by Admin on 19/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class PaymentSelectionViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(payment: Payment) {
        nameLabel.text = payment.name
        
    }

}

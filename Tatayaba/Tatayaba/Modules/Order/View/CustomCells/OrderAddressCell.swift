//
//  OrderMainInfoCell.swift
//  Tatayaba
//
//  Created by Ahmed Elsman on 10/26/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class OrderAddressCell: UITableViewCell {

    @IBOutlet weak var shippingAddress: UILabel!
    @IBOutlet weak var billingAddress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

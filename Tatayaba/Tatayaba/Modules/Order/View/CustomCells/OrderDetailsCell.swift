//
//  OrderMainInfoCell.swift
//  Tatayaba
//
//  Created by Ahmed Elsman on 10/26/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class OrderDetailsCell: UITableViewCell {

    @IBOutlet weak var shippingValue: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var paymentMethod: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  OrderTableViewCell.swift
//  Tatayaba
//
//  Created by Admin on 24/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(order: OrderModel) {
        self.orderIdLabel.text = "# \(order.identifier)"
        self.totalPriceLabel.text = order.totalPrice.formattedPrice
    }
}

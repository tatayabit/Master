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

    @IBOutlet weak var status_Image: UIImageView!
    @IBOutlet weak var StatusLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(order: OrderModel) {
        self.orderIdLabel.text = "# \(order.identifier)"
        self.totalPriceLabel.text = order.totalPrice.formattedPrice
        self.timeLabel.text = order.timestamp
        self.StatusLabel.text = order.status
        if self.StatusLabel.text == "Completed"{
            self.StatusLabel.textColor = UIColor.init(hexString:"#AEC779")
           // status_Image.image =  Need images in idx not ther
        }else if self.StatusLabel.text == "Processing"{
             self.StatusLabel.textColor = UIColor.init(hexString:"#43B7F2")
        }else if self.StatusLabel.text == "Pending"{
             self.StatusLabel.textColor = UIColor.init(hexString:"#D5B950")
        }else if self.StatusLabel.text == "Cancelled"{
             self.StatusLabel.textColor = UIColor.init(hexString:"#EC4C6F")
        }
        
    }
}

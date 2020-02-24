//
//  OrderTableViewCell.swift
//  Tatayaba
//
//  Created by Admin on 24/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol OrderTableViewCellDelegate: class {
    func didSelectViewOrder(at indexPath: IndexPath)
}

class OrderTableViewCell: UITableViewCell {
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var status_Image: UIImageView!
    @IBOutlet weak var StatusLabel: UILabel!
    private var indexPath: IndexPath?

    weak var delegate: OrderTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(order: OrderModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        self.orderIdLabel.text = "# \(order.identifier)"
        self.totalPriceLabel.text = order.totalPrice.formattedKWDPrice
        let orderStampDouble = Double(order.timestamp)
        let timeInterval = TimeInterval(orderStampDouble ?? 0.0)
        self.timeLabel.text = Date(timeIntervalSince1970: timeInterval).toString(dateFormat: "yyyy-MM-dd HH:mm:ss")
        self.StatusLabel.text = order.status
        if self.StatusLabel.text == "Completed"{
            self.StatusLabel.text = "Completed".localized()
            self.StatusLabel.textColor = UIColor.init(hexString:"#AEC779")
           // status_Image.image =  Need images in idx not ther
        }else if self.StatusLabel.text == "Processing"{
            self.StatusLabel.text = "Processed".localized()
            self.StatusLabel.textColor = UIColor.init(hexString:"#43B7F2")
        }else if self.StatusLabel.text == "Cash on delivery"{
            self.StatusLabel.text = "Cash on delivery".localized()
            self.StatusLabel.sizeToFit()
        }else if self.StatusLabel.text == "Pending"{
            self.StatusLabel.text = "Pending".localized()
            self.StatusLabel.textColor = UIColor.init(hexString:"#D5B950")
        }else if self.StatusLabel.text == "Cancelled"{
            self.StatusLabel.text = "Cancelled".localized()
            self.StatusLabel.textColor = UIColor.init(hexString:"#EC4C6F")
        }
    }

    // MARK:- IBActions
    @IBAction func viewOrderAction(_ sender: Any) {
        if let delegate = delegate {
            guard let indexPath = indexPath else { return }
            delegate.didSelectViewOrder(at: indexPath)
        }
    }

}

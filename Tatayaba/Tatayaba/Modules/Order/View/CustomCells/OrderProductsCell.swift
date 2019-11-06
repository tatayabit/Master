//
//  OrderMainInfoCell.swift
//  Tatayaba
//
//  Created by Ahmed Elsman on 10/26/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class OrderProductsCell: UITableViewCell {

    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var paidPrice: UILabel!
    @IBOutlet weak var productStatus: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(product: Product) {
        productName.text = product.name
        companyName.text = product.supplierName
        productPrice.text = product.price
        paidPrice.text = product.price
        productStatus.text = product.productStatus
    }
}

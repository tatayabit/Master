//
//  OrderMainInfoCell.swift
//  Tatayaba
//
//  Created by Ahmed Elsman on 10/26/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

private enum ProductStatus: String, CaseIterable {
    case activeProduct = "A"
    case hiddenProduct = "H"
    case deletedProduct = "D"
}
class OrderProductsCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var companyName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var paidPrice: UILabel!
    @IBOutlet weak var productStatus: UILabel!
    @IBOutlet weak var amountLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configCell(product: Product) {
        productImage.sd_setImage(with: URL(string: product.mainPair.detailedPair.imageUrl), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
        productName.text = product.name
        amountLBL.text = String(product.amount)
        companyName.text = product.supplierName
        productPrice.text = product.price.formattedPrice
        paidPrice.text = product.price.formattedPrice
        var productStatusTitle: String = ""
        if product.productStatus == ProductStatus.activeProduct.rawValue {
            productStatusTitle = "active".localized()
        } else if product.productStatus == ProductStatus.hiddenProduct.rawValue {
            productStatusTitle = "hidden".localized()
        } else if product.productStatus == ProductStatus.deletedProduct.rawValue {
            productStatusTitle = "disabled".localized()
        }
        productStatus.text = productStatusTitle
    }
}

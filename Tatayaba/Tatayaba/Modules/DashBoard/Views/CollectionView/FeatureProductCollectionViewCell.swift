//
//  FeatureProductCollectionViewCell.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class FeatureProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet var product_Images: UIImageView!
    @IBOutlet var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(product: Product) {
        priceLabel.text = product.price.formattedPrice
    }
}

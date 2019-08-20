//
//  FeatureProductCollectionViewCell.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import SDWebImage

class FeatureProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet var productImageView: UIImageView!
    @IBOutlet var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(product: Product) {
        priceLabel.text = product.price.formattedPrice
        if !product.imageUrl.isEmpty {
            productImageView.sd_setImage(with: URL(string: product.imageUrl), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
        }
    }
}

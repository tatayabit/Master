//
//  NewProductCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import SDWebImage

class NewProductCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


    func configure(product: Product) {
        productNameLabel.text = product.name
        if !product.mainPair.detailedPair.imageUrl.isEmpty {
            productImageView.sd_setImage(with: URL(string: product.mainPair.detailedPair.imageUrl), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
        }
    }
}

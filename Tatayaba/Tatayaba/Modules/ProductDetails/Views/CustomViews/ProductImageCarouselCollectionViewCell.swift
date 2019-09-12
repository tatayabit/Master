//
//  ProductImageCarouselCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/17/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProductImageCarouselCollectionViewCell: UICollectionViewCell {

    @IBOutlet var productImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(imageUrl: String) {
        productImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)

    }
}

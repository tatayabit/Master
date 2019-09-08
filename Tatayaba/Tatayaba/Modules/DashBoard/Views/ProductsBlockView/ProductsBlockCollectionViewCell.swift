//
//  ProductsBlockCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProductsBlockCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ product: Product) {

        bannerImageView.sd_setImage(with: URL(string: product.mainPair.detailedPair.imageUrl), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)
    }

}

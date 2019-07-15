//
//  WishlistCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/11/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class WishlistCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var favoritButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.cornerRadius = 6
    }

    func configure(product: Product) {

    }

}

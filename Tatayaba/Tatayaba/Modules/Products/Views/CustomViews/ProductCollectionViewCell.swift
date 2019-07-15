//
//  ProductCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell, ConfigurableCell {
    static var height: CGFloat? { return 270 }

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var wishlistButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var addToCartButton: UIButton!


    func configure(data: Product, eventable: Eventable?) {
//        UIColor.brandDarkBlue
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

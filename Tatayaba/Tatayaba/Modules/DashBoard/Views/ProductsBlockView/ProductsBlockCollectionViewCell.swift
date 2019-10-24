//
//  ProductsBlockCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol ProductsBlockCollectionViewCellDelegate: class {
    func didSelectAddToCartCell(indexPath: IndexPath)
    func didSelectOneClickBuy(indexPath: IndexPath)
}

class ProductsBlockCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    var indexPath: IndexPath = IndexPath(item: 0, section: 0)
    weak var delegate: ProductsBlockCollectionViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(_ product: Product, indexPath: IndexPath) {
        bannerImageView.sd_setImage(with: URL(string: product.mainPair.detailedPair.imageUrl), placeholderImage: nil, options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)

        nameLabel.text = product.supplierName == "None" ? "" : product.supplierName
        descriptionLabel.text = product.name
        priceLabel.text = product.price.formattedPrice
        self.indexPath = indexPath
    }

    @IBAction func addToCartAction(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.didSelectAddToCartCell(indexPath: self.indexPath)
        }
    }
    
    @IBAction func oneClickBuyAction(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.didSelectOneClickBuy(indexPath: self.indexPath)
        }
    }
}

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
    @IBOutlet weak var outOfStockLabel: UILabel!
    @IBOutlet weak var freeDeliveryLabel: UILabel!
    @IBOutlet weak var discountPercentageLabel: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    

    var indexPath: IndexPath = IndexPath(item: 0, section: 0)
    weak var delegate: ProductsBlockCollectionViewCellDelegate?
    
    var cellBlockName : String = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        outOfStockLabel.text = "Out of stock"
        freeDeliveryLabel.text = "free Delivery".localized()
        
        self.discountPercentageLabel.isHidden = true
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        self.layoutIfNeeded()
    }
    func configure(_ product: Product, indexPath: IndexPath) {
        bannerImageView.sd_setImage(with: URL(string: product.mainPair.detailedPair.imageUrl), placeholderImage: UIImage(named: "productPlaceholder"), options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)

        nameLabel.text = product.supplierName == "None" ? "" : product.supplierName
        descriptionLabel.text = product.name
        priceLabel.text = product.price.formattedPrice
        outOfStockLabel.isHidden = product.isInStock
        if(product.is_free_delivery == "Y"){
            freeDeliveryLabel.isHidden = false
        }else{
            freeDeliveryLabel.isHidden = true
        }
        freeDeliveryLabel.sizeToFit()
        print("OFF".localized())
        self.discountPercentageLabel.text = product.discountPercentage + "OFF".localized()
        
        
        if let percentage = Float(product.priceBeforeDiscount) {
            self.discountPercentageLabel.isHidden = !(percentage > 0)
        } else {
            self.discountPercentageLabel.isHidden = true
        }
        if let discountPercentage = Float(product.discountPercentage) {
            self.discountPercentageLabel.isHidden = !(discountPercentage > 0)
        } else {
            self.discountPercentageLabel.isHidden = true
        }
        
        self.indexPath = indexPath
        
        if product.hasOptions {
            addToCartButton.setTitle("OPTIONS...".localized(), for: .normal)
        } else {
            addToCartButton.setTitle("ADD TO CART".localized(), for: .normal)
        }
        
        self.layoutIfNeeded()
    }
    func configureProduct(_ product: Product, indexPath: IndexPath, cellBlockName : String) {
        bannerImageView.sd_setImage(with: URL(string: product.mainPair.detailedPair.imageUrl), placeholderImage: UIImage(named: "productPlaceholder"), options: [.refreshCached, .continueInBackground, .allowInvalidSSLCertificates], completed: nil)

        nameLabel.text = product.supplierName == "None" ? "" : product.supplierName
        descriptionLabel.text = product.name
        priceLabel.text = product.price.formattedPrice
        outOfStockLabel.isHidden = product.isInStock
        if(product.is_free_delivery == "Y"){
            freeDeliveryLabel.isHidden = false
        }else{
            freeDeliveryLabel.isHidden = true
        }
        freeDeliveryLabel.sizeToFit()
        self.discountPercentageLabel.text = product.discountPercentage + "OFF".localized()
        
        
        if let percentage = Float(product.priceBeforeDiscount) {
            self.discountPercentageLabel.isHidden = !(percentage > 0)
        } else {
            self.discountPercentageLabel.isHidden = true
        }
        if let discountPercentage = Float(product.discountPercentage) {
            self.discountPercentageLabel.isHidden = !(discountPercentage > 0)
        } else {
            self.discountPercentageLabel.isHidden = true
        }
        
        self.indexPath = indexPath
        
        if product.hasOptions {
            addToCartButton.setTitle("OPTIONS...".localized(), for: .normal)
        } else {
            addToCartButton.setTitle("ADD TO CART".localized(), for: .normal)
        }
        self.cellBlockName = cellBlockName
        
        self.layoutIfNeeded()
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

extension Constants {
    struct ProductDetails {
        static let options = "OPTIONS...".localized()
        static let addToCart = "ADD TO CART".localized()
        
    }
}

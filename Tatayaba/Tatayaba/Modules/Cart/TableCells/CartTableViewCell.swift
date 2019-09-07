//
//  CartTableViewCell.swift
//  Tatayaba
//
//  Created by Admin on 15/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet var removeItem: UIButton!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
//    @IBOutlet weak var addMoreButton: UIButton!
//    @IBOutlet weak var removeOneButton: UIButton!

    var cartItemX: CartItem = CartItem()

    var onAddMoreClick: (() -> ())?
    var onRemoveOneCountClick: (() -> ())?
    var onRemoveItemClick: (() -> ())?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(product: Product, cartItem: CartItem) {
        self.nameLabel.text = product.name
        self.cartItemX = cartItem
        updatePrice(product: product, cartItem: cartItem)
    }

    func updatePrice(product: Product, cartItem: CartItem) {
        self.quantityLabel.text = "QTY " + String(cartItem.count)

        if let price = Float(product.price) {
            let total: Float =  price * Float(cartItem.count)
            self.priceLabel.text = String(total).formattedPrice
        }
    }

    //MARK:- IBActions
    @IBAction func addOneCountAction(_ sender: Any) {
        if let block = onAddMoreClick {
            block()
        }
    }

    @IBAction func removeOneCountAction(_ sender: Any) {
        if cartItemX.count > 1 {
            if let block = onRemoveOneCountClick {
                block()
            }
        }
    }

    @IBAction func removeItemAction(_ sender: Any) {
        if let block = onRemoveItemClick {
            block()
        }
    }

}

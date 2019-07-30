//
//  CartModel.swift
//  Tatayaba
//
//  Created by Admin on 15/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class Cart {
    static let shared = Cart()
    private var products = [CartItem]()
    private var productsArr = [Product]()

    var defaultShipping: ShippingMethod?

    var productsCount: Int { return products.count }
    var subtotalPrice: String { return String(calculateSubTotal()).formattedPrice }

    //MARK:- Operational functions
    func addProduct(product: Product) {
        if productExistedInCart(product: product) {
            let cartItem = self.cartItem(for: product)
            increaseCount(cartItem: cartItem)
        } else {
            let productModel = CartItem(productId: product.identifier, productName: product.name)
            products.append(productModel)
            productsArr.append(product)
        }
    }

    func cartItem(for product: Product) -> CartItem {
        return products.filter({ $0.productId == product.identifier }).first ?? CartItem(productId: product.identifier, productName: product.name)
    }

    func removeProduct(cartItem: CartItem) {

    }

    func increaseCount(cartItem: CartItem) {
        cartItem.increaseCount(by: 1)
    }

    func decreaseCount(cartItem: CartItem) {
        cartItem.decreaseCount(by: 1)
    }

    func product(at indexPath: IndexPath) -> (Product, CartItem) {
        guard products.count > 0 else { return (Product(), CartItem()) }
        return (productsArr[indexPath.row], products[indexPath.row])
    }

    func calculateSubTotal() -> Float {
        var total: Float = 0
        if productsArr.count > 0 {
        for i in 0...productsArr.count - 1 {
            let productItem = productsArr[i]
            let cartItem = products[i]
            let price = (productItem.price as NSString).floatValue//Float(productItem.price) ?? 0.0
            let quantity = Float(cartItem.count)
            total += (quantity * price)
        }
        }
        return total
        
    }

    func cartItemsList() -> [CartItem] {
        return self.products
    }

    func productsList() -> [Product] {
        return self.productsArr
    }

    //MARK:- Private functions
    private func productExistedInCart(product: Product) -> Bool {
        let existed = products.contains(where: { $0.productId == product.identifier})
        return existed
    }
}

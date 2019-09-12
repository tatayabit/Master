//
//  Cart.swift
//  Tatayaba
//
//  Created by Admin on 15/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class Cart {
    static let shared = Cart()
    private var cartItemsArr = [CartItem]()
    private var productsArr = [Product]()

    var defaultShipping: ShippingMethod?

    var productsCount: Int { return cartItemsArr.count }
    var subtotalPrice: String { return String(calculateSubTotal()).formattedPrice }

    //MARK:- Operational functions
    func addProduct(product: Product) {
        if productExistedInCart(product: product) {
            let cartItem = self.cartItem(for: product)
            increaseCount(cartItem: cartItem)
        } else {
            let productModel = CartItem(productId: String(product.identifier), productName: product.name)
            cartItemsArr.append(productModel)
            productsArr.append(product)
        }
    }

    func cartItem(for product: Product) -> CartItem {
        return cartItemsArr.filter({ $0.productId == String(product.identifier) }).first ?? CartItem(productId: String(product.identifier), productName: product.name)
    }

    func removeProduct(at indexPath: IndexPath) {
        let cartProduct = product(at: indexPath)
        cartItemsArr.remove(at: indexPath.row)
        productsArr.remove(at: indexPath.row)
    }

    func increaseCount(cartItem: CartItem) {
        cartItem.increaseCount(by: 1)
    }

    func decreaseCount(cartItem: CartItem) {
        cartItem.decreaseCount(by: 1)
    }

    func product(at indexPath: IndexPath) -> (Product, CartItem) {
        guard cartItemsArr.count > 0 else { return (Product(), CartItem()) }
        return (productsArr[indexPath.row], cartItemsArr[indexPath.row])
    }

    func calculateSubTotal() -> Float {
        var total: Float = 0
        if productsArr.count > 0 {
        for i in 0...productsArr.count - 1 {
            let productItem = productsArr[i]
            let cartItem = cartItemsArr[i]
            let price = (productItem.price as NSString).floatValue//Float(productItem.price) ?? 0.0
            let quantity = Float(cartItem.count)
            total += (quantity * price)
        }
        }
        return total
        
    }

    func cartItemsList() -> [CartItem] {
        return self.cartItemsArr
    }

    func productsList() -> [Product] {
        return self.productsArr
    }

    //MARK:- Private functions
    private func productExistedInCart(product: Product) -> Bool {
        let existed = cartItemsArr.contains(where: { $0.productId == String(product.identifier) })
        return existed
    }
}

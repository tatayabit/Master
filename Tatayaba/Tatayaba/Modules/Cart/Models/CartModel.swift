//
//  CartModel.swift
//  Tatayaba
//
//  Created by Admin on 15/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

class Cart {
    static let shared = Cart()
    private var products = [CartItem]()


    //MARK:- Operational functions
    func addProduct(product: Product) {
        if productExistedInCart(product: product) {
            let cartItem = self.cartItem(for: product)
            increaseCount(cartItem: cartItem)
        } else {
            let productModel = CartItem(productId: product.identifier, productName: product.name)
            products.append(productModel)
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

    //MARK:- Private functions
    private func productExistedInCart(product: Product) -> Bool {
        let existed = products.contains(where: { $0.productId == product.identifier})
        return existed
    }

}

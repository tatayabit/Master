//
//  CartItem.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/22/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct CartItemOptions: Codable {
    var optionId: String
    var variantId: String
}

class CartItem: Codable {
    var productId: String
    var productName: String
    var options: [CartItemOptions]?
    var count: Int = 0
    private let maxCount = 99
    private let minCount = 0

    init(productId: String = "" , productName: String = "", quantity: Int = 1, options: [CartItemOptions]? = nil) {
        self.productId = productId
        self.productName = productName
        self.increaseCount(by: quantity)
        self.options = options
    }
    

    func increaseCount(by value: Int) {
        if count < maxCount {
            self.count += value
        }
    }

    func decreaseCount(by value: Int) {
        if count > minCount {
            self.count -= value
        }
    }


}

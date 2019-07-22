//
//  CartItem.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/22/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

class CartItem {
    var productId: String
    var productName: String
    var count: Int = 0

    private let maxCount = 99
    private let minCount = 0

    init(productId: String, productName: String) {
        self.productId = productId
        self.productName = productName
        self.increaseCount(by: 1)
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

//
//  CheckoutCompletedViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/29/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct CheckoutCompletedViewModel {
    var orderIdText: String { return "ORDER # \(orderId)" }
    private var orderId: String

    init(orderId: String) {
        self.orderId = orderId
        self.clearCart()
    }
    
    func clearCart() {
        Cart.shared.reset()
    }
}

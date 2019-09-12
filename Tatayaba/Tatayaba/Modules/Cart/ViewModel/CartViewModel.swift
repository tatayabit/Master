//
//  CartViewModel.swift
//  Tatayaba
//
//  Created by Admin on 15/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct CartPricingModel {
    var title: String
    var value: String
}

protocol CartViewModelDelegate: class {
    func didFinishLoadingPricing()
}

class CartViewModel {

    var pricingList = [CartPricingModel]()
    let cart = Cart.shared

    weak var delegate: CartViewModelDelegate?

    init() {
        loadPricingListContent()
    }

    func loadPricingListContent() {
        pricingList.removeAll()
        let model = CartPricingModel(title: "Subtotal", value: cart.subtotalPrice)
        pricingList.append(model)
        if let delegate = delegate {
            delegate.didFinishLoadingPricing()
        }
    }


}

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
    
    private let cartApiClient = CartAPIClient()

    weak var delegate: CartViewModelDelegate?

    init() {
        loadPricingListContent()
    }

    func loadPricingListContent() {
        pricingList.removeAll()
        var model = CartPricingModel(title: Constants.Cart.subtotal, value: cart.subtotalPrice)
        pricingList.append(model)

        model = CartPricingModel(title: Constants.Cart.shipping, value: cart.shippingFormatedPrice)
        pricingList.append(model)
        if let delegate = delegate {
            delegate.didFinishLoadingPricing()
        }
    }
    
    //MARK:- Api
    func applyCoupon(couponCode: String) {
//        cartApiClient.applyCoupon(couponCode: <#T##String#>, completion: <#T##(APIResult<PlaceOrderResult?, MoyaError>) -> Void#>)
    }
}

extension Constants {
    struct Cart {
        static let subtotal = "Subtotal".localized()
        static let shipping = "Shipping".localized()
        static let items = "items".localized()
        static let cartTotal = "Cart Total".localized()
        static let cartEmpty = "Your Cart is Empty!".localized()
    }
}

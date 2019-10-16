//
//  CartViewModel.swift
//  Tatayaba
//
//  Created by Admin on 15/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//
import Moya

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
        loadPricingListContent(couponValue: "0", taxValue: "0", shippingValue: "0")
    }

    func loadPricingListContent(couponValue: String, taxValue: String, shippingValue: String) {
        pricingList.removeAll()
        var model = CartPricingModel(title: Constants.Cart.subtotal, value: cart.subtotalPrice)
        pricingList.append(model)

        model = CartPricingModel(title: Constants.Cart.shipping, value: cart.shippingFormatedPrice)
        pricingList.append(model)
        
        model = CartPricingModel(title: Constants.Cart.shipping, value: shippingValue + " KD")
        pricingList.append(model)
        
        model = CartPricingModel(title: Constants.Cart.tax, value: taxValue + " KD")
        pricingList.append(model)
        
        model = CartPricingModel(title: Constants.Cart.coupon, value: couponValue + " KD")
        pricingList.append(model)
        
        if let delegate = delegate {
            delegate.didFinishLoadingPricing()
        }
    }
    
    //MARK:- Api
    func applyCoupon(couponCode: String, completion: @escaping (APIResult<couponResponse?, MoyaError>) -> Void) {
        cartApiClient.applyCoupon(couponCode: couponCode) { result in
            switch result {
            case .success(let couponResult):
                if let coupon = couponResult {
                    print(coupon)
                }
            case .failure(let error):
                print("the error \(error)")
            }
            completion(result)
        }
    }
    
    func getTaxAndShipping(countryCode: String, completion: @escaping (APIResult<TaxAndShippingResponse?, MoyaError>) -> Void) {
        cartApiClient.getTaxAndShipping(countryCode: countryCode) { result in
            switch result {
            case .success(let taxAndShippingResult):
                if let taxAndShipping = taxAndShippingResult {
                    print(taxAndShipping)
                }
            case .failure(let error):
                print("the error \(error)")
            }
            completion(result)
        }
    }
}

extension Constants {
    struct Cart {
        static let subtotal = "Subtotal".localized()
        static let shipping = "Shipping".localized()
        static let tax = "Tax".localized()
        static let coupon = "Coupon".localized()
        static let items = "items".localized()
        static let cartTotal = "Cart Total".localized()
        static let cartEmpty = "Your Cart is Empty!".localized()
    }
}

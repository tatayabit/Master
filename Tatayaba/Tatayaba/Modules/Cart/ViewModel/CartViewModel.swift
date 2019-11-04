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
        loadPricingListContent(couponValue: "0", taxValue: nil, shippingValue: "0")
    }
    
    func loadPricingListContent(couponValue: String, taxValue: Tax?, shippingValue: String) {
        pricingList.removeAll()
        let cartClass: CartPricingItems = CartPricingItems()
        var model = CartPricingModel(title: cartClass.subtotal, value: cart.subtotalPrice)
        pricingList.append(model)
        
        //        model = CartPricingModel(title: Constants.Cart.shipping, value: cart.shippingFormatedPrice)
        //        pricingList.append(model)
        
        model = CartPricingModel(title: cartClass.shipping, value: shippingValue.formattedPrice)
        pricingList.append(model)
        
        if taxValue?.customDuties?.type == "P" {
            model = CartPricingModel(title: cartClass.customDuties, value: "\(taxValue?.customDuties?.value ?? "0")%")
        }else {
            model = CartPricingModel(title: cartClass.customDuties, value: taxValue?.customDuties?.value?.formattedPrice ?? "0")
        }
        
        pricingList.append(model)
        
        if taxValue?.vat?.type == "P" {
            model = CartPricingModel(title: cartClass.tax, value: "\(taxValue?.vat?.value ?? "0")%")
        }else {
            model = CartPricingModel(title: cartClass.tax, value: taxValue?.vat?.value?.formattedPrice ?? "0")
        }
        
        pricingList.append(model)
        
        model = CartPricingModel(title: cartClass.coupon, value: couponValue.formattedPrice)
        pricingList.append(model)
        
        if let delegate = delegate {
            delegate.didFinishLoadingPricing()
        }
    }
    
    // MARK:- One Click Buy
    func setOneClickBuy(isOneClickBuy: Bool) {
        cart.isOneClickBuy = isOneClickBuy
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


class CartPricingItems {
    var subtotal = "Subtotal".localized()
    var shipping = "Shipping".localized()
    var tax = "Tax".localized()
    var customDuties = "CustomDuties".localized()
    var coupon = "Coupon".localized()
    var items = "items".localized()
    var cartTotal = "Cart Total".localized()
    var cartEmpty = "Your Cart is Empty!".localized()
    var Quantity = "Quantity".localized()
}


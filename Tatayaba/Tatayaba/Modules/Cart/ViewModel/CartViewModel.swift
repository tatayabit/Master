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
        CurrencySettings.shared.addCurrencyDelegate(delegate: self)
    }
    
    func loadPricingListContent(couponValue: String, taxValue: Tax?, shippingValue: String) {
        pricingList.removeAll()
        let cartClass: CartPricingItems = CartPricingItems()
        var model = CartPricingModel(title: cartClass.subtotal, value: cart.subtotalPrice)
        pricingList.append(model)
        
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
        
        model = CartPricingModel(title: cartClass.coupon, value: couponValue)
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
    func applyCoupon(couponCode: String, email: String, completion: @escaping (APIResult<CouponResponse?, MoyaError>) -> Void) {
        cartApiClient.applyCoupon(parameters: self.getApplyCouponJsonString(couponCode: couponCode, email: email)) { result in
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
    
    func getPricesWithUpdatedCurrency(to currency: Currency) {
        if cart.productsList().count == 0 { return }
        cartApiClient.getPricesWithUpdatedCurrency(parameters: self.getConvertingCurrencyJsonString(with: currency.currencyId)) { result in
            switch result {
            case .success(let convertedPricesResult):
                if let convertedPrices = convertedPricesResult {
                    print(convertedPrices)
                    self.cart.updatePricesWithNewCurrency(currencyResponse: convertedPrices)
                }
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    func getShippingPricesWithUpdatedCurrency(completion: @escaping (APIResult<ConvertedCurrency?, MoyaError>) -> Void) {
        if cart.productsList().count == 0 { return }
        cartApiClient.getPricesWithUpdatedCurrency(parameters: self.getShippingConvertingCurrencyJsonString()) { result in
            switch result {
            case .success(let convertedPricesResult):
                if let convertedPrices = convertedPricesResult {
                    print(convertedPrices)
                    if var shipping = CountrySettings.shared.shipping {
                        shipping.rateValue = convertedPrices.shippingCharge
                        CountrySettings.shared.updateShipping(shippingValue: shipping)
                    }
                }
            case .failure(let error):
                print("the error \(error)")
            }
            completion(result)
        }
    }
    
    // MARK:- Get Apply Coupon format
    private func getApplyCouponJsonString(couponCode: String, email: String) -> [String: Any] {
        let productsList = cart.productsList()
        var requestJson = [String: Any]()

        var productsParms = [[String: Any]]()
        
        for product in productsList {
            let singleProductDict = [
                "product_id" : product.identifier,
            ]
            productsParms.append(singleProductDict)
        }
        
        requestJson["products"] = productsParms
        requestJson["shipping_id"] = CountrySettings.shared.shipping?.shippingId
        requestJson["coupon_code"] = couponCode
        requestJson["country_code"] = CountrySettings.shared.currentCountry?.code
        requestJson["email"] = email
        requestJson["currency_id"] = CurrencySettings.shared.currentCurrency?.currencyId
        requestJson["coupon_data"] = true
        
        return requestJson
    }

    
    // MARK:- Convert to get currency format
    private func getConvertingCurrencyJsonString(with currencyId: String) -> [String: Any] {
        let productsList = cart.productsList()
        var requestJson = [String: Any]()
        var productsParms = [[String: Any]]()
        
        for product in productsList {
            let singleProductDict = [
                "product_id" : product.identifier,
                "price" : product.price
            ]
            productsParms.append(singleProductDict)
        }
        
        requestJson["products"] = productsParms
        requestJson["to_currency_id"] = currencyId
        requestJson["convert_data"] = true
        
        return requestJson
    }
    
    private func getShippingConvertingCurrencyJsonString() -> [String: Any] {
        var shippingRate = "1.00"
        if let shipping = CountrySettings.shared.shipping {
            shippingRate = shipping.rateValue ?? "1.00"
        }
        var requestJson = [String: Any]()
        
        requestJson["products"] = []
        requestJson["shipping_charge"] = shippingRate
        requestJson["to_currency_id"] = CurrencySettings.shared.currentCurrency?.currencyId//currencyId
        requestJson["convert_data"] = true
        
        return requestJson
    }
}

extension CartViewModel: CurrencySettingsDelegate {
    func currencyDidChange(to currency: Currency) {
        self.getPricesWithUpdatedCurrency(to: currency)
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

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
    var cartItemsArr = [CartItem]()
    private var productsArr = [Product]()
    var paymentMethod: PaymentMethod?
//    let viewModel = CartViewModel.shared
    private let cartApiClient = CartAPIClient()
    let cartSaving = CartSaving()
    var cart_ids = [String: String]()
    var productsCount: Int { return cartItemsArr.count }
    var subtotalPrice: String { return String(self.calculateSubTotal()).formattedPrice }
    var totalPrice: String { return String(self.calculateTotal()).formattedPrice }
    var totalPriceValueRounded : Float = 0.0
    var isOneClickBuy: Bool = false
    var couponCode: String = ""
    
    
    //MARK:- LoadDataFromCaching
    func loadDataFromCaching() {
        let cartSaving = CartSaving()

        if let cartList = cartSaving.loadCartItemsFromKeyChain() {
            self.cartItemsArr = cartList
        }
        
        if let cartProducts = cartSaving.loadCartProductsFromKeyChain() {
            self.productsArr = cartProducts
        }
        
        if let payment = cartSaving.loadPaymentMethodFromKeyChain() {
            self.paymentMethod = payment
        }
    }
    
    //MARK:- SaveCartToCaching
    func saveCartToCaching() {
        let cartSaving = CartSaving()

        cartSaving.saveProducts(products: self.productsArr)
        cartSaving.saveCartItems(cartItems: self.cartItemsArr)
        cartSaving.savePaymentMethod(method: self.paymentMethod)
    }
    
    //MARK:- Operational functions
    
    
    func addProduct(product: Product, quantity: Int = 1, options: [CartItemOptions]? = nil) {
        if productExistedInCart(product: product) {
            let cartItem = self.cartItem(for: product, options: options)
            let maxQuantity = product.maxQuantity
            let stockQuantity = product.amount
            let max = Int(maxQuantity) ?? 0
            if max <= cartItem.count {
                // max reached
            } else if stockQuantity > max {
                increaseCount(cartItem: cartItem, quantity: quantity)
            }
        } else {
            let productModel = CartItem(productId: String(product.identifier), productName: product.name, quantity: quantity, options: options)
            cartItemsArr.append(productModel)
            productsArr.append(product)
            if (self.checkLogin()){
                self.addCartToServer()
            }else{
                saveCartToCaching()
            }
        }
        updateTabBarCount()
        
    }

    func cartItem(for product: Product, options: [CartItemOptions]?) -> CartItem {
        return cartItemsArr.filter({ $0.productId == String(product.identifier) }).first ?? CartItem(productId: String(product.identifier), productName: product.name, options: options)
    }

    func removeProduct(at indexPath: IndexPath) {
        cartItemsArr.remove(at: indexPath.row)
        productsArr.remove(at: indexPath.row)
        updateTabBarCount()
        
        if (self.checkLogin()) {
            //self.deleteItemFromServer(cart_id: self.cart_ids.keysForValue(value: productsArr[indexPath.row].identifier)[0])
        } else {
            saveCartToCaching()
        }
    }

    func increaseCount(cartItem: CartItem, quantity: Int) {
        cartItem.increaseCount(by: quantity)
        updateTabBarCount()
        if (self.checkLogin()){
            self.addCartToServer()
        }else{
            saveCartToCaching()
        }
    }

    func decreaseCount(cartItem: CartItem) {
        cartItem.decreaseCount(by: 1)
        updateTabBarCount()
        if (self.checkLogin()){
            self.addCartToServer()
        }else{
            saveCartToCaching()
        }
    }

    func product(at indexPath: IndexPath) -> (Product, CartItem) {
        guard cartItemsArr.count > 0 else { return (Product(), CartItem()) }
        return (productsArr[indexPath.row], cartItemsArr[indexPath.row])
    }

    // MARK:- UpdateCartCount
    func updateTabBarCount() {
        if productsCount > 0 {
            AppDelegate.shared.rootViewController.tabBar.items?[4].badgeValue = String(productsCount)
        } else {
            AppDelegate.shared.rootViewController.tabBar.items?[4].badgeValue = nil
        }
    }
    
    //MARK:- Calculate Price
    func calculateSubTotal() -> Float {
        var total: Float = 0
        if productsArr.count > 0 {
            for i in 0...productsArr.count - 1 {
                let productItem = productsArr[i]
                let cartItem = cartItemsArr[i]
                let price = (productItem.price as NSString).floatValue
                let quantity = Float(cartItem.count)
                total += (quantity * price)
            }
        }
        return total
        
    }

    func calculateTotal() -> Float {
        return calculateSubTotal()
    }

    //MARK:- Get Cart Item / Product
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
    
    // MARK:- Update Currency
    func updatePricesWithNewCurrency(currencyResponse: ConvertedCurrency) {
        self.updateProductsPrices(productsResponse: currencyResponse.products)
        
    }
    
    private func updateProductsPrices(productsResponse: [ConvertedProduct]) {
        print("cartProducts before new prices: \(productsArr)")
        for cartProductIndex in 0...productsArr.count - 1 {
            var product = productsArr[cartProductIndex]
            
            for convertedProduct in productsResponse {
                if convertedProduct.identifier == product.identifier {
                    product.price = convertedProduct.price
                    productsArr[cartProductIndex] = product
                }
            }
        }
        
        print("cartProducts after new prices: \(productsArr)")
    }
    
    // MARK:- Reset
    func reset() {
        self.productsArr.removeAll()
        self.cartItemsArr.removeAll()
        self.isOneClickBuy = false
        self.paymentMethod = nil
        self.couponCode = ""
        updateTabBarCount()
//        saveCartToCaching()
    }
}

extension Cart {
    
    func getUserId() -> String {
        let customer = Customer.shared
        if customer.loggedin {
            guard let user = customer.user else { return "0" }
            return user.identifier
        }
        return "0"
    }
    
    func getProductOptions(cartOptions: [CartItemOptions]) -> [[String: String]] {
        var optionsParms = [[String: String]]()
        for optionSection in cartOptions {
            optionsParms.append([optionSection.optionId: optionSection.variantId])
        }
        return optionsParms
    }
    
    func getProductsModel() -> [String: Any] {
        let cartItems = self.cartItemsList()
        var productsParms = [String: Any]()

        for i in 0...cartItems.count - 1 {
            let cartItemX = cartItems[i]

            var optionsParms = [[String: String]]()
            if let options = cartItemX.options {
                if options.count > 0 {
                   optionsParms = getProductOptions(cartOptions: options)
                }
            }
            
            var productPP = [String: Any]()
            productPP["product_id"] = cartItemX.productId
            productPP["amount"] = "\(cartItemX.count)"
            
            if optionsParms.count > 0 {
                productPP["product_options"] = optionsParms

            }
            productsParms["\(cartItemX.productId)"] = productPP
            
        }
        return productsParms
    }
    
    func updateLocalStorage() {
        deleteLocalStorage()
        saveCartToCaching()
    }
    
    func getLocalStorage() {
        if let cartList = cartSaving.loadCartItemsFromKeyChain() {
            print(cartList.count)
        }
    }
    
    func deleteLocalStorage() {
        if checkLocalStorage() {
            cartSaving.deleteCartCashing()
        }
    }
    
    func checkLogin() -> Bool {
        return Customer.shared.loggedin
    }
    func checkLocalStorage() -> Bool {
        return cartSaving.checkLocalCaching()
    }
    
    func getCartFromServer() {
        let userId = getUserId()
        cartApiClient.getServerCart( userId: userId) { result in
            switch result {
            case .success(let response):
                guard let getCartResult = response else { return }
                self.updateLocalStorage()
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    func addCartToServer() -> Void {
        let userId = getUserId()
        let paymentId = self.paymentMethod?.paymentId ?? "0"

        cartApiClient.addServerCart(products: getProductsModel(), userId: userId, paymentId: paymentId) { result in
            switch result {
            case .success(let response):
                //let updateServerCartResponse = try UpdateServerCartResponse(response)
                guard let updateCartResult = response else { return }
                print(updateCartResult.cart_ids.count)
                //print(updateCartResult.cart_ids.count)
                self.updateLocalStorage()
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    func deleteAllCartFromServer() {
        let userId = getUserId()
        cartApiClient.deleteAllFromCart( userId: userId) { result in
            switch result {
            case .success(_):
                print("Deleted sucssfully")
                self.updateLocalStorage()
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    func deleteItemFromServer(cart_id:String) {
        let userId = getUserId()
        cartApiClient.deleteItemfromCart(userId: userId, cart_id: cart_id) { result in
            switch result {
            case .success( _):
                print("Deleted sucssfully")
                self.updateLocalStorage()
            case .failure(let error):
                print("the error \(error)")
            }
            
        }
    }
}

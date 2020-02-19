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
    var cartLocalItemsArr = [CartItem]()
    var cartCompareItemsList = [CartItem]()
    private var productsArr = [Product]()
    private var productsLocalArr = [Product]()
    var paymentMethod: PaymentMethod?

    var productsCount: Int { return cartItemsArr.count }
    var subtotalPrice: String { return String(self.calculateSubTotal()).formattedPrice }
    var totalPrice: String { return String(self.calculateTotal()).formattedPrice }
    var totalPriceValueRounded : Float = 0.0
    var isOneClickBuy: Bool = false
    var couponCode: String = ""
    var couponType: String = ""
    
    
    //MARK:- LoadDataFromCaching
    func loadDataFromCaching() {
        let cartSaving = CartSaving()

        if let cartList = cartSaving.loadCartItemsFromKeyChain() {
            self.cartLocalItemsArr = cartList
        }
        
        if let cartProducts = cartSaving.loadCartProductsFromKeyChain() {
            self.productsLocalArr = cartProducts
        }
        
        if let payment = cartSaving.loadPaymentMethodFromKeyChain() {
            self.paymentMethod = payment
        }
        
        if (!Customer.shared.loggedin) {
            self.cartItemsArr = self.cartLocalItemsArr
            self.productsArr = self.productsLocalArr
        }
    }
    
    func loadDataFromServer() {
        CartViewModel.shared.getServerCart(completion: { result in
            switch result {
            case .success(let response):
                guard let getCartResult = response else { return }
                self.productsArr = getCartResult.products ?? [Product]()
                self.cartItemsArr = self.setItemsArr(products:getCartResult.products ?? [])
                self.updateTabBarCount()
                self.saveCartToCaching()
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
            case .failure(let error):
                print("the error \(error)")
            }
            
        })
    }
    
    func loadDataFromServerSync(completion:@escaping() -> Void) {
        CartViewModel.shared.getServerCart(completion: { result in
            switch result {
            case .success(let response):
                guard let getCartResult = response else { return }
                self.productsArr = getCartResult.products ?? [Product]()
                self.cartItemsArr = self.setItemsArr(products:getCartResult.products ?? [])
                self.updateTabBarCount()
                self.saveCartToCaching()
                completion()
            case .failure(let error):
                print("the error \(error)")
            }
            
        })
    }
    
    func callUpdateServerCart(){
        CartViewModel.shared.updateServerCart() { result in
                switch result {
                case .success(let response):
                    guard let placeOrderResult = response else { return }
                    print(placeOrderResult)
                    self.loadDataFromServer()
                case .failure(let error):
                    print("the error \(error)")
                }
            }
        }
    
    func addProductToServerCart(product:CartItem){
        CartViewModel.shared.updateServerCartWithProduct(product: product) { result in
            switch result {
            case .success(let response):
                guard let placeOrderResult = response else { return }
                print(placeOrderResult)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    func deleteProductFromoServerCart(product:Product){
        CartViewModel.shared.deleteItemInServerCart(cartId: product.productInCart) { result in
            switch result {
            case .success(let response):
                guard let placeOrderResult = response else { return }
                print(placeOrderResult)
            case .failure(let error):
                print("the error \(error)")
            }
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
        var cartItem : CartItem
        if productExistedInCart(product: product) {
            cartItem = self.cartItem(for: product, options: options)
            let maxQuantity = product.maxQuantity
            let stockQuantity = product.amount
            let max = Int(maxQuantity) ?? 0
            if max <= cartItem.count {
                // max reached
            } else if stockQuantity > max {
                increaseCount(cartItem: cartItem, quantity: quantity)
            }
        } else {
            cartItem = CartItem(productId: String(product.identifier), productName: product.name, quantity: quantity, options: options)
            cartItemsArr.append(cartItem)
            productsArr.append(product)
        }
        updateTabBarCount()
        saveCartToCaching()
        addProductToServerCart(product: cartItem)
        
    }

    func cartItem(for product: Product, options: [CartItemOptions]?) -> CartItem {
        return cartItemsArr.filter({ $0.productId == String(product.identifier) }).first ?? CartItem(productId: String(product.identifier), productName: product.name, options: options)
    }
    func setItemsArr(products:[Product]) -> [CartItem]{
        var tempCartItems = [CartItem]()
        for product in products {
            let cartItem = CartItem(productId: String(product.identifier), productName: product.name, options: getCartItemOptions(options: product.productOptions))
            tempCartItems.append(cartItem)
        }
        return tempCartItems
    }
    
    func getCartItemOptions(options:[ProductOption]) -> [CartItemOptions] {
        var cartOptions = [CartItemOptions]()
        var CartItemOption: CartItemOptions!
        for option in options {
           CartItemOption = CartItemOptions(optionId: option.identifier, variantId: option.variants[0].identifier)
            cartOptions.append(CartItemOption)
        }
        return cartOptions
    }

    func removeProduct(at indexPath: IndexPath) {
        deleteProductFromoServerCart(product: productsArr[indexPath.row])
        cartItemsArr.remove(at: indexPath.row)
        productsArr.remove(at: indexPath.row)
        print(indexPath.row)
        updateTabBarCount()
        saveCartToCaching()
    }

    func increaseCount(cartItem: CartItem, quantity: Int) {
        cartItem.increaseCount(by: quantity)
        updateTabBarCount()
        saveCartToCaching()
    }

    func decreaseCount(cartItem: CartItem) {
        cartItem.decreaseCount(by: 1)
        updateTabBarCount()
        saveCartToCaching()
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
    
    func getCartCompareItemsList() -> [CartItem] {
        return self.cartCompareItemsList
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
        self.couponType = ""
        updateTabBarCount()
//        saveCartToCaching()
    }
    
    func resetLocal() {
            self.productsArr.removeAll()
            self.cartItemsArr.removeAll()
            self.isOneClickBuy = false
            self.paymentMethod = nil
            self.couponCode = ""
            self.couponType = ""
            updateTabBarCount()
            saveCartToCaching()
        }
    
    func syncCart(){
        self.cartCompareItemsList.removeAll()
        //getLocal
        loadDataFromCaching()
        
        //getServer
        loadDataFromServerSync(completion: {
            //compare
            if (self.cartLocalItemsArr.count == 0) {return}
            for cartItem in self.cartLocalItemsArr {
                let results = self.cartItemsArr.filter { $0.productId == cartItem.productId }
                if results.count == 0 {
                    self.cartCompareItemsList.append(cartItem)
                }
            }
            //add to server
            if(self.cartCompareItemsList.count > 0){
                self.callUpdateServerCart()
            }
        })
        
        
        
    }
}




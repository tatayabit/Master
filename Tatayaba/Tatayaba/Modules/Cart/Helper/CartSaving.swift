//
//  CartSaving.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 12/10/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import SwiftKeychainWrapper

class CartSaving {
    
    let cartItemsKey = "cartItemsKey"
    let cartProductsKey = "cartProductsKey"
    let paymentMethodsKey = "paymentMethodsKey"
    
    //MARK:- Save to KeyChain
    func saveCartItems(cartItems: [CartItem]) {
        let data = try? PropertyListEncoder().encode(cartItems)
        guard let dataX = data else { return }
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: dataX)
        let saved = KeychainWrapper.standard.set(encodedData, forKey: cartItemsKey)
        print("saved: \(saved)")
    }
    
    func saveProducts(products: [Product]) {
        let data = try? PropertyListEncoder().encode(products)
        guard let dataX = data else { return }
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: dataX)
        let saved = KeychainWrapper.standard.set(encodedData, forKey: cartProductsKey)
        print("saved: \(saved)")
    }
    
    func savePaymentMethod(method: PaymentMethod?) {
        guard let method = method else { return }
        let data = try? PropertyListEncoder().encode(method)
        guard let dataX = data else { return }
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: dataX)
        let saved = KeychainWrapper.standard.set(encodedData, forKey: paymentMethodsKey)
        print("saved: \(saved)")
    }
    
    //MARK:- Load from KeyChain
    func loadCartItemsFromKeyChain() -> [CartItem]? {
        guard let savedData = KeychainWrapper.standard.data(forKey: cartItemsKey) else { return nil }
        guard let encodedData = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? Data else { return nil }

//        let cartDataDecoded = try? PropertyListDecoder().decode([CartItem].self, from: encodedData)
        var cartItems = [CartItem]()
        print("loaded cartItems: \(String(describing: cartItems))")
        
        do {
           let cartDataDecoded = try PropertyListDecoder().decode([CartItem].self, from: encodedData)
            cartItems = cartDataDecoded
            return cartItems
        }catch {
            print("Unexpected error: \(error).")
        }
        return cartItems
    }
    
    func loadCartProductsFromKeyChain() -> [Product]? {
        guard let savedData = KeychainWrapper.standard.data(forKey: cartProductsKey) else { return nil }
        guard let encodedData = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? Data else { return nil }

        do {
            let cartDataDecoded = try PropertyListDecoder().decode([Product].self, from: encodedData)
            let cartProducts = cartDataDecoded
            print("loaded cartProducts: \(String(describing: cartProducts))")
            return cartProducts
        } catch let err {
            print("error: \(err)")
            return nil
        }
//        let cartDataDecoded = try? PropertyListDecoder().decode([Product].self, from: encodedData)
//        let cartProducts = cartDataDecoded
//        print("loaded cartProducts: \(String(describing: cartProducts))")
//        return cartProducts
    }

    func loadPaymentMethodFromKeyChain() -> PaymentMethod? {
        guard let savedData = KeychainWrapper.standard.data(forKey: paymentMethodsKey) else { return nil }
        guard let encodedData = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? Data else { return nil }

        let cartDataDecoded = try? PropertyListDecoder().decode(PaymentMethod.self, from: encodedData)
        let method = cartDataDecoded
        print("loaded method: \(String(describing: method))")
        return method
    }
    //MARK:- Delete from KeyChain
    func deleteCartCashing(){
         let _: Bool = KeychainWrapper.standard.removeObject(forKey: cartItemsKey)
    }
    //MARK:- check KeyChain
    func checkLocalCaching() -> Bool {
        guard let savedData = KeychainWrapper.standard.data(forKey: cartItemsKey) else { return false }
        guard let encodedData = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? Data else { return false }
        var cartItems = [CartItem]()
        print("loaded cartItems: \(String(describing: cartItems))")
        do {
           let cartDataDecoded = try PropertyListDecoder().decode([CartItem].self, from: encodedData)
            cartItems = cartDataDecoded
            if (cartItems.count > 0) {
                return true
            } else {
                return false
            }
        }catch {
            print("Unexpected error: \(error).")
            return false
        }
        
        
    }
}

extension Dictionary where Value: Equatable {
/// Returns all keys mapped to the specified value.
    /// ```
    /// let dict = ["A": 1, "B": 2, "C": 3]
    /// let keys = dict.keysForValue(2)
    /// assert(keys == ["B"])
    /// assert(dict["B"] == 2)
    /// ```
    func keysForValue(value: Value) -> [Key] {
        return flatMap { (key: Key, val: Value) -> Key? in
            value == val ? key : nil
        }
    }
}

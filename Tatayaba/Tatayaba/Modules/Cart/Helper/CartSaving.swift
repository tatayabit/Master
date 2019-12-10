//
//  CartSaving.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 12/10/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import SwiftKeychainWrapper

let cartItemsKey = "cartItemsKey"


class CartSaving {
    //MARK:- UserData KeyChain
//      private func saveCartDataToKeyChain() {
//          let data = try? PropertyListEncoder().encode(userObj)
//          guard let dataX = data else { return }
//          let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: dataX)
//          let saved = KeychainWrapper.standard.set(encodedData, forKey: cartDataKey)
//          print("saved: \(saved)")
//      }
//
//      private func loadCartDataFromKeyChain() {
//          guard let savedData = KeychainWrapper.standard.data(forKey: cartDataKey) else { return }
//          guard let encodedData = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? Data else { return }
//
//          let userDataDecoded = try? PropertyListDecoder().decode(User.self, from: encodedData)
//          userData = userDataDecoded
//          print("loaded userData: \(String(describing: cartDataKey))")
//      }
    
    func saveCartItems(cartItems: [CartItem]) {
        let data = try? PropertyListEncoder().encode(cartItems)
        guard let dataX = data else { return }
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: dataX)
        let saved = KeychainWrapper.standard.set(encodedData, forKey: cartItemsKey)
        print("saved: \(saved)")
    }
    
    func saveProducts(products: [Product]) {
        
    }
    
    func savePaymentMethod(method: PaymentMethod) {
        
    }
    
}

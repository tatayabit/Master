//
//  Customer.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/6/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import SwiftKeychainWrapper

class Customer {

    let userDataKey = "userDataKey"

    static let shared = Customer()
    private var userData: User?

    var loggedin: Bool { return userData != nil }

    var user: User? { return userData }

    //MARK:- Load Data
    func loadData() {
        loadUserDataFromKeyChain()
    }

    func setUser(_ userObj: User) {
        userData = userObj as User?
        print("userData: \(String(describing: userData))")
        saveUserDataToKeyChain(userObj: userObj)
    }

    func logout() {
        userData = nil
        print("loggedOut: \(String(describing: userData))")
        KeychainWrapper.standard.removeObject(forKey: userDataKey)
    }

    //MARK:- UserData KeyChain
    private func saveUserDataToKeyChain(userObj: User) {
        let data = try? PropertyListEncoder().encode(userObj)
        guard let dataX = data else { return }
        let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: dataX)
        let saved = KeychainWrapper.standard.set(encodedData, forKey: userDataKey)
        print("saved: \(saved)")
    }

    private func loadUserDataFromKeyChain() {
        guard let savedData = KeychainWrapper.standard.data(forKey: userDataKey) else { return }
        guard let encodedData = NSKeyedUnarchiver.unarchiveObject(with: savedData) as? Data else { return }

        let userDataDecoded = try? PropertyListDecoder().decode(User.self, from: encodedData)
        userData = userDataDecoded
        print("loaded userData: \(String(describing: userData))")
    }
}

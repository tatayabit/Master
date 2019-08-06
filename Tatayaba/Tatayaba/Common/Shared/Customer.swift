//
//  Customer.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/6/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

class Customer {
    static let shared = Customer()
    private var userData: User?

    var loggedin: Bool { return userData != nil }

    var user: User? { return userData }


    func setUser(_ userObj: User) {
        userData = userObj as User?
        print("userData: \(String(describing: userData))")
    }

    func logout() {
        userData = nil
        print("loggedOut: \(String(describing: userData))")
    }

}

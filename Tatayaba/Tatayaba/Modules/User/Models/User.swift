//
//  User.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/4/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct User {
    var identifier: String
    var email: String
    var firstname: String
    var lastname: String
    var password: String
    var phone: String

    var billingAddress: String
    var billingCity: String
    var billingCountry: String
    var billingPhone: String
    var shippingCity: String
    var shippingCountry: String
    var shippingPhone: String
    var shippingAddress: String
    var state: String
    var zipCode: String

    init(email: String, firstname: String = "", lastname: String = "", password: String, identifier: String = "", phone: String = "", billingAddress: String = "", billingCity: String = "", billingCountry: String = "", billingPhone: String = "", shippingCity: String = "", shippingCountry: String = "", shippingPhone: String = "", shippingAddress: String = "",state: String = "",zipCode: String = "") {
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.password = password
        self.identifier = identifier
        self.phone = phone

        self.billingAddress = billingAddress
        self.billingCity = billingCity
        self.billingCountry = billingCountry
        self.billingPhone = billingPhone
        self.shippingCity = shippingCity
        self.shippingCountry = shippingCountry
        self.shippingPhone = shippingPhone
        self.shippingAddress = shippingAddress
        self.state = state
        self.zipCode = zipCode
    }
}


extension User: Codable {
    enum UserCodingKeys: String, CodingKey {
        case email
        case firstname
        case lastname
        case password
        case identifier = "user_id"
        case phone

        case billingAddress = "b_address"
        case billingCity = "b_city"
        case billingCountry = "b_county"
        case billingPhone = "b_phone"
        case shippingCity = "s_city"
        case shippingCountry = "s_county"
        case shippingPhone = "s_phone"
        case shippingAddress = "s_address"
        case state = "b_state"
        case zipCode = "b_zipcode"
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)

        identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        firstname = try container.decodeIfPresent(String.self, forKey: .firstname) ?? ""
        lastname = try container.decodeIfPresent(String.self, forKey: .lastname) ?? ""
        password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""

        billingAddress = try container.decodeIfPresent(String.self, forKey: .billingAddress) ?? ""
        billingCity = try container.decodeIfPresent(String.self, forKey: .billingCity) ?? ""
        billingCountry = try container.decodeIfPresent(String.self, forKey: .billingCountry) ?? ""
        billingPhone = try container.decodeIfPresent(String.self, forKey: .billingPhone) ?? ""
        shippingCity = try container.decodeIfPresent(String.self, forKey: .shippingCity) ?? ""
        shippingCountry = try container.decodeIfPresent(String.self, forKey: .shippingCountry) ?? ""
        shippingPhone = try container.decodeIfPresent(String.self, forKey: .shippingPhone) ?? ""
        shippingAddress = try container.decodeIfPresent(String.self, forKey: .shippingAddress) ?? ""
        state = try container.decodeIfPresent(String.self, forKey: .state) ?? ""
        zipCode = try container.decodeIfPresent(String.self, forKey: .zipCode) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)

        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(firstname, forKey: .firstname)
        try container.encodeIfPresent(lastname, forKey: .lastname)
        try container.encodeIfPresent(password, forKey: .password)
        try container.encodeIfPresent(phone, forKey: .phone)

        try container.encodeIfPresent(billingAddress, forKey: .billingAddress)
        try container.encodeIfPresent(billingCity, forKey: .billingCity)
        try container.encodeIfPresent(billingCountry, forKey: .billingCountry)
        try container.encodeIfPresent(billingPhone, forKey: .billingPhone)
        try container.encodeIfPresent(shippingCity, forKey: .shippingCity)
        try container.encodeIfPresent(shippingCountry, forKey: .shippingCountry)
        try container.encodeIfPresent(shippingPhone, forKey: .shippingPhone)
        try container.encodeIfPresent(shippingAddress, forKey: .shippingAddress)
        try container.encodeIfPresent(state, forKey: .state)
        try container.encodeIfPresent(zipCode, forKey: .zipCode)

    }
}

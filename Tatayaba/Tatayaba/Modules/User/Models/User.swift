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


    init(email: String, firstname: String = "", lastname: String = "", password: String, identifier: String = "", phone: String = "" ) {
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.password = password
        self.identifier = identifier
        self.phone = phone
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
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)

        identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        firstname = try container.decodeIfPresent(String.self, forKey: .firstname) ?? ""
        lastname = try container.decodeIfPresent(String.self, forKey: .lastname) ?? ""
        password = try container.decodeIfPresent(String.self, forKey: .password) ?? ""
        phone = try container.decodeIfPresent(String.self, forKey: .phone) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)

        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(email, forKey: .email)
        try container.encodeIfPresent(firstname, forKey: .firstname)
        try container.encodeIfPresent(lastname, forKey: .lastname)
        try container.encodeIfPresent(password, forKey: .password)
        try container.encodeIfPresent(phone, forKey: .phone)
    }
}

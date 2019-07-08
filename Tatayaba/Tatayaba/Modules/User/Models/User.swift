//
//  User.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/4/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct User {
    var identifier: String?
    var email: String?
    var firstname: String?
    var lastname: String?
    var password: String?

    init(email: String, firstname: String, lastname: String, password: String, identifier: String? = "") {
        self.email = email
        self.firstname = firstname
        self.lastname = lastname
        self.password = password
        self.identifier = identifier
    }
}


extension User: Codable {
    enum UserCodingKeys: String, CodingKey {
        case email
        case firstname
        case lastname
        case password
        case identifier = "user_id"
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)

        identifier = try? container.decode(String.self, forKey: .identifier)
        email = try? container.decode(String.self, forKey: .email)
        firstname = try? container.decode(String.self, forKey: .firstname)
        lastname = try? container.decode(String.self, forKey: .lastname)
        password = try? container.decode(String.self, forKey: .password)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)

        try? container.encode(identifier, forKey: .identifier)
        try? container.encode(email, forKey: .email)
        try? container.encode(firstname, forKey: .firstname)
        try? container.encode(lastname, forKey: .lastname)
        try? container.encode(password, forKey: .password)
    }
}

//
//  LoginResult.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/4/19.
//  Copyright © 2019 Shaik. All rights reserved.
//


struct LoginResult {
    var user: User
}

extension LoginResult: Codable {
    enum LoginResultCodingKeys: String, CodingKey {
        case user = "user_profile"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LoginResultCodingKeys.self)
        user = try container.decodeIfPresent(User.self, forKey: .user) ?? User(email: "", password: "")
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: LoginResultCodingKeys.self)
        try container.encodeIfPresent(user, forKey: .user)
    }
}

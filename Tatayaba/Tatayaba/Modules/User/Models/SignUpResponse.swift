//
//  SignUpResponse.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/7/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct SignUpResponse {
    var userId: Int = 0
    var profileId: String?

    init(userId: Int, profileId: String?) {
        self.userId = userId
        self.profileId = profileId
    }
}

extension SignUpResponse: Codable {
    enum UserCodingKeys: String, CodingKey {
        case userId = "user_id"
        case profileId = "profile_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)

        userId = try container.decode(Int.self, forKey: .userId)
        profileId = try? container.decode(String.self, forKey: .profileId)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)

        try? container.encode(userId, forKey: .userId)
        try? container.encode(profileId, forKey: .profileId)
    }
}

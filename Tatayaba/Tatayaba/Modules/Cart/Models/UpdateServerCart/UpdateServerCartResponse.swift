//
//  UpdateServerCartResponse.swift
//  Tatayaba
//
//  Created by new on 12/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct UpdateServerCartResponse : Codable{
    var cart_ids = [String:Int]()

    enum UserCodingKeys: String, CodingKey {
        case cart_ids = "cart_ids"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        cart_ids = try container.decode([String:Int].self, forKey: .cart_ids)
    }
}

//extension UpdateServerCartResponse {
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: UserCodingKeys.self)
//
//        try? container.encode(cart_ids, forKey: .cart_ids)
//    }
//}

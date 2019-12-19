//
//  CartContentResponse.swift
//  Tatayaba
//
//  Created by new on 12/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation
struct CartContentResponse : Codable{
    var cart_ids = [String:Int]()

    enum UserCodingKeys: String, CodingKey {
        case cart_ids = "cart_ids"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        cart_ids = try container.decode([String:Int].self, forKey: .cart_ids)
    }
}

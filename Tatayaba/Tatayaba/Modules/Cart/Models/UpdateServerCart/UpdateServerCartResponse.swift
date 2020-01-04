//
//  UpdateServerCartResponse.swift
//  Tatayaba
//
//  Created by new on 12/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct UpdateServerCartResponse : Codable{
    var cart_ids = [String:String]()

    enum UserCodingKeys: String, CodingKey {
        case cart_ids = "cart_ids"
    }

    init(from decoder: Decoder) throws {
        
        print(decoder.userInfo)
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        print(decoder)
//        print(try container.decode(Dictionary.self, forKey: .cart_ids))
        cart_ids = try container.decode(Dictionary.self, forKey: .cart_ids)
    }
}

struct Cart_ids : Codable {
    let key : String?
    let value : String?

    enum CodingKeys: String, CodingKey {

        case key
        case value
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        key = try values.decodeIfPresent(String.self, forKey: .key)
        value = try values.decodeIfPresent(String.self, forKey: .value)
    }

}

//
//  BasePriceFormatted.swift
//  Tatayaba
//
//  Created by new on 1/30/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//

import Foundation

struct BasePriceFormatted : Codable {

        var price : String?
        var symbol : String?

        enum CodingKeys: String, CodingKey {
                case price = "price"
                case symbol = "symbol"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                price = try values.decodeIfPresent(String.self, forKey: .price)
                symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
        }

}

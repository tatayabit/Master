//
//  CurrencyFormatted.swift
//  Tatayaba
//
//  Created by new on 12/29/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation
struct CurrencyFormatted : Codable{
    var price: String = ""
    var symbol: String = ""

    enum UserCodingKeys: String, CodingKey {
        case price = "price"
        case symbol = "symbol"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        
        price = try container.decode(String.self, forKey: .price)
        symbol = try container.decode(String.self, forKey: .symbol)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)

        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(symbol, forKey: .symbol)
        
    }
}


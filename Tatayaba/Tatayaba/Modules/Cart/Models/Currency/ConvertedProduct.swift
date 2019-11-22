//
//  ConvertedProduct.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 11/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ConvertedProduct {
    var identifier: String
    var price: String
    
    init(identifier: String = "", price: String = "") {
        self.identifier = identifier
        self.price = price
    }
}

extension ConvertedProduct: Codable {
    enum CodingKeys: String, CodingKey {
        case identifier = "product_id"
        case price
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""
        price = try container.decodeIfPresent(String.self, forKey: .price) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(identifier, forKey: .identifier)
    }
}

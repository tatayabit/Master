//
//  ProductMainPair.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/7/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ProductMainPair {
    var detailedPair: ProductDetailedPair

    init(detailedPair: ProductDetailedPair = ProductDetailedPair()) {
        self.detailedPair = detailedPair
    }
}

extension ProductMainPair: Codable {
    enum ProductMainPairCodingKeys: String, CodingKey {
        case detailedPair = "detailed"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductMainPairCodingKeys.self)
        detailedPair = try container.decodeIfPresent(ProductDetailedPair.self, forKey: .detailedPair) ?? ProductDetailedPair()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductMainPairCodingKeys.self)
        try container.encodeIfPresent(detailedPair, forKey: .detailedPair)
    }
}

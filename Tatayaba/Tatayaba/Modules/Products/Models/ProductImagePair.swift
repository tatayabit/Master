//
//  ProductImagePair.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 11/25/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ProductImagePair {
    var icon: ProductIcon
    
    init(icon: ProductIcon = ProductIcon()) {
        self.icon = icon
    }
}

extension ProductImagePair: Codable {
    enum CodingKeys: String, CodingKey {
        case icon
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        icon = try container.decodeIfPresent(ProductIcon.self, forKey: .icon) ?? ProductIcon()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(icon, forKey: .icon)
    }
}

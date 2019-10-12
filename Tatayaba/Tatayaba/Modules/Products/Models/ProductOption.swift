//
//  ProductOption.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/9/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ProductOption {
    var identifier: String
    var name: String
    var variants: [ProductVariant]
    
    init(identifier: String = "", name: String = "", variants: [ProductVariant] = [ProductVariant]()) {
        self.identifier = identifier
        self.name = name
        self.variants = variants
    }
}

extension ProductOption: Codable {
    enum ProductOptionCodingKeys: String, CodingKey {
        case identifier = "option_id"
        case name = "option_name"
        case variants
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductOptionCodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        variants = try container.decodeIfPresent([ProductVariant].self, forKey: .variants) ?? [ProductVariant]()

        var idVal = ""
        if let identifierString = try? container.decode(String.self, forKey: .identifier) {
            idVal = identifierString
        } else if let identifierInt = try? container.decode(Int.self, forKey: .identifier) {
            idVal = "\(identifierInt)"
        }
        identifier = idVal
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductOptionCodingKeys.self)
        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(variants, forKey: .variants)
    }
}

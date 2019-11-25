//
//  ProductVariant.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/9/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ProductVariant {
    var identifier: String
    var name: String
    var imagePair: ProductImagePair
    
    init(identifier: String = "", name: String = "", imagePair: ProductImagePair = ProductImagePair()) {
        self.identifier = identifier
        self.name = name
        self.imagePair = imagePair
    }
}

extension ProductVariant: Codable {
    enum ProductVariantCodingKeys: String, CodingKey {
        case identifier = "variant_id"
        case name = "variant_name"
        case imagePair = "image_pair"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductVariantCodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        imagePair = try container.decodeIfPresent(ProductImagePair.self, forKey: .imagePair) ?? ProductImagePair()

        var idVal = ""
        if let identifierString = try? container.decode(String.self, forKey: .identifier) {
            idVal = identifierString
        } else if let identifierInt = try? container.decode(Int.self, forKey: .identifier) {
            idVal = "\(identifierInt)"
        }
        identifier = idVal
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductVariantCodingKeys.self)
        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(imagePair, forKey: .imagePair)
    }
}

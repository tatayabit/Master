//
//  ProductDetailedPair.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/7/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ProductDetailedPair {
    var imageUrl: String

    init(imageUrl: String = "") {
        self.imageUrl = imageUrl
    }
}

extension ProductDetailedPair: Codable {
    enum ProductDetailedPairCodingKeys: String, CodingKey {
        case imageUrl = "https_image_path"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductDetailedPairCodingKeys.self)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductDetailedPairCodingKeys.self)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
    }
}

//
//  BlockProduct.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/20/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct BlockProduct {
    var blockProductId: String
    var imagePair: BlockImagePair
    var fullDetails: Product

    init(blockProductId: String = "" , imagePair: BlockImagePair = BlockImagePair(), fullDetails: Product) {
        self.blockProductId = blockProductId
        self.imagePair = imagePair
        self.fullDetails = fullDetails
    }
}

extension BlockProduct: Codable {
    enum BlockProductCodingKeys: String, CodingKey {
        case blockProductId = "id"
        case imagePair = "image_pair"
        case fullDetails = "full_details"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BlockProductCodingKeys.self)

        blockProductId = try container.decodeIfPresent(String.self, forKey: .blockProductId) ?? ""
        imagePair = try container.decodeIfPresent(BlockImagePair.self, forKey: .imagePair) ?? BlockImagePair()
        fullDetails = try container.decodeIfPresent(Product.self, forKey: .fullDetails) ?? Product()

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BlockProductCodingKeys.self)

        try container.encodeIfPresent(blockProductId, forKey: .blockProductId)
        try container.encodeIfPresent(imagePair, forKey: .imagePair)
        try container.encodeIfPresent(fullDetails, forKey: .fullDetails)
    }
}

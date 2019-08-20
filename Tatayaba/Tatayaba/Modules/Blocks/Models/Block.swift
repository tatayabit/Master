//
//  Block.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/19/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct Block {
    var blockId: String = ""
    var type: String = ""
    var name: String = ""
    var products: [BlockProduct]

    init(blockId: String = "" , type: String = "", name: String = "", products: [BlockProduct] = [BlockProduct]()) {
        self.blockId = blockId
        self.type = type
        self.name = name
        self.products = products
    }
}

extension Block: Codable {
    enum BlockCodingKeys: String, CodingKey {
        case blockId = "block_id"
        case type
        case name
        case products
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BlockCodingKeys.self)

        blockId = try container.decodeIfPresent(String.self, forKey: .blockId) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        products = try container.decodeIfPresent([BlockProduct].self, forKey: .products) ?? [BlockProduct]()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BlockCodingKeys.self)

        try container.encodeIfPresent(blockId, forKey: .blockId)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(products, forKey: .products)
    }
}

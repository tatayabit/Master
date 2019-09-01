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
    var products: [Product]//[BlockProduct]
    var banners: [BlockBanner]

    init(blockId: String = "" , type: String = "", name: String = "", products: [Product] = [Product](), banners: [BlockBanner] = [BlockBanner]()) {
        self.blockId = blockId
        self.type = type
        self.name = name
        self.products = products
        self.banners = banners
    }
}

extension Block: Codable {
    enum BlockCodingKeys: String, CodingKey {
        case blockId = "block_id"
        case type
        case name
        case products
        case banners
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BlockCodingKeys.self)

        blockId = try container.decodeIfPresent(String.self, forKey: .blockId) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        products = try container.decodeIfPresent([Product].self, forKey: .products) ?? [Product]()
        banners = try container.decodeIfPresent([BlockBanner].self, forKey: .banners) ?? [BlockBanner]()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BlockCodingKeys.self)

        try container.encodeIfPresent(blockId, forKey: .blockId)
        try container.encodeIfPresent(type, forKey: .type)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(products, forKey: .products)
        try container.encodeIfPresent(banners, forKey: .banners)
    }
}

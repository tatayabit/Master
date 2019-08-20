//
//  BlockImagePair.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/20/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct BlockImagePair {
    var detailed: BlockImagePairDetailed

    init(detailed: BlockImagePairDetailed = BlockImagePairDetailed()) {
        self.detailed = detailed
    }
}

extension BlockImagePair: Codable {
    enum BlockImagePairCodingKeys: String, CodingKey {
        case detailed
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BlockImagePairCodingKeys.self)

        detailed = try container.decodeIfPresent(BlockImagePairDetailed.self, forKey: .detailed) ?? BlockImagePairDetailed()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BlockImagePairCodingKeys.self)

        try container.encodeIfPresent(detailed, forKey: .detailed)

    }
}

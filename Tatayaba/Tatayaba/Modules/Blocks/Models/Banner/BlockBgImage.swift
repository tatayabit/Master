//
//  BlockBgImage.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/20/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct BlockBgImage {
    var icon: BlockBgImageIcon

    init(icon: BlockBgImageIcon = BlockBgImageIcon()) {
        self.icon = icon
    }
}

extension BlockBgImage: Codable {
    enum BlockBgImageCodingKeys: String, CodingKey {
        case icon
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BlockBgImageCodingKeys.self)
        icon = try container.decodeIfPresent(BlockBgImageIcon.self, forKey: .icon) ?? BlockBgImageIcon()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BlockBgImageCodingKeys.self)
        try container.encodeIfPresent(icon, forKey: .icon)
    }
}

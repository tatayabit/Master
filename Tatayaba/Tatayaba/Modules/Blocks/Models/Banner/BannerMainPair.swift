//
//  BannerMainPair.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/4/19.
//  Copyright © 2019 Shaik. All rights reserved.
//


struct BannerMainPair {
    var icon: BlockBgImageIcon

    init(icon: BlockBgImageIcon = BlockBgImageIcon()) {
        self.icon = icon
    }
}

extension BannerMainPair: Codable {
    enum BannerMainPairCodingKeys: String, CodingKey {
        case icon
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BannerMainPairCodingKeys.self)
        icon = try container.decodeIfPresent(BlockBgImageIcon.self, forKey: .icon) ?? BlockBgImageIcon()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BannerMainPairCodingKeys.self)
        try container.encodeIfPresent(icon, forKey: .icon)
    }
}

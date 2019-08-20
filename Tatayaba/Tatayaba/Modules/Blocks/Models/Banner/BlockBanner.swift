//
//  BlockBanner.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/20/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct BlockBanner {
    var bannerId: String
    var url: String
    var bgImage: BlockBgImage

    init(bannerId: String = "", url: String, bgImage: BlockBgImage) {
        self.bannerId = bannerId
        self.url = url
        self.bgImage = bgImage
    }
}

extension BlockBanner: Codable {
    enum BlockBannerCodingKeys: String, CodingKey {
        case bannerId = "banner_id"
        case url
        case bgImage = "bg_image"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BlockBannerCodingKeys.self)
        bannerId = try container.decodeIfPresent(String.self, forKey: .bannerId) ?? ""
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
        bgImage = try container.decodeIfPresent(BlockBgImage.self, forKey: .bgImage) ?? BlockBgImage()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BlockBannerCodingKeys.self)
        try container.encodeIfPresent(bannerId, forKey: .bannerId)
        try container.encodeIfPresent(url, forKey: .url)
        try container.encodeIfPresent(bgImage, forKey: .bgImage)
    }
}

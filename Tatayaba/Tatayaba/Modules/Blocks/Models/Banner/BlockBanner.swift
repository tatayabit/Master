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
//    var bgImage: BlockBgImage
    var bannerMainPair: BannerMainPair

    init(bannerId: String = "", url: String, bannerMainPair: BannerMainPair) {
        self.bannerId = bannerId
        self.url = url
//        self.bgImage = bgImage
        self.bannerMainPair = bannerMainPair
    }
}

extension BlockBanner: Codable {
    enum BlockBannerCodingKeys: String, CodingKey {
        case bannerId = "banner_id"
        case url
//        case bgImage = "bg_image"
        case bannerMainPair = "main_pair"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BlockBannerCodingKeys.self)
        bannerId = try container.decodeIfPresent(String.self, forKey: .bannerId) ?? ""
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
//        bgImage = try container.decodeIfPresent(BlockBgImage.self, forKey: .bgImage) ?? BlockBgImage()
        bannerMainPair = try container.decodeIfPresent(BannerMainPair.self, forKey: .bannerMainPair) ?? BannerMainPair()

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BlockBannerCodingKeys.self)
        try container.encodeIfPresent(bannerId, forKey: .bannerId)
        try container.encodeIfPresent(url, forKey: .url)
//        try container.encodeIfPresent(bgImage, forKey: .bgImage)
        try container.encodeIfPresent(bannerMainPair, forKey: .bannerMainPair)
    }
}

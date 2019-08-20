//
//  BlockBgImageIcon.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/20/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct BlockBgImageIcon {
    var imagePath: String = ""

    init(imagePath: String = "") {
        self.imagePath = imagePath
    }
}

extension BlockBgImageIcon: Codable {
    enum BlockBgImageIconCodingKeys: String, CodingKey {
        case imagePath = "https_image_path"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BlockBgImageIconCodingKeys.self)
        imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BlockBgImageIconCodingKeys.self)
        try container.encodeIfPresent(imagePath, forKey: .imagePath)
    }
}

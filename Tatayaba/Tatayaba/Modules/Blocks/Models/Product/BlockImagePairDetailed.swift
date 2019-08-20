//
//  BlockImagePairDetailed.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/20/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct BlockImagePairDetailed {
    var imagePath: String = ""

    init(imagePath: String = "") {
        self.imagePath = imagePath
    }
}

extension BlockImagePairDetailed: Codable {
    enum BlockImagePairDetailedCodingKeys: String, CodingKey {
        case imagePath = "https_image_path"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BlockImagePairDetailedCodingKeys.self)
        imagePath = try container.decodeIfPresent(String.self, forKey: .imagePath) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: BlockImagePairDetailedCodingKeys.self)
        try container.encodeIfPresent(imagePath, forKey: .imagePath)
    }
}

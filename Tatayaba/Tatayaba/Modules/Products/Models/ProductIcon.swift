//
//  ProductIcon.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 11/25/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ProductIcon {
    var url: String
    
    init(url: String = "") {
        self.url = url
    }
}

extension ProductIcon: Codable {
    enum CodingKeys: String, CodingKey {
        case url = "https_image_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(url, forKey: .url)
    }
}

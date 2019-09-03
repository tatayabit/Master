//
//  SupplierIcon.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation


struct SupplierIcon {
    var url: String = ""

    init(url: String = "") {
        self.url = url
    }
}

extension SupplierIcon: Codable {
    enum SupplierIconCodingKeys: String, CodingKey {
        case url = "https_image_path"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SupplierIconCodingKeys.self)

        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SupplierIconCodingKeys.self)

        try container.encodeIfPresent(url, forKey: .url)
    }
}

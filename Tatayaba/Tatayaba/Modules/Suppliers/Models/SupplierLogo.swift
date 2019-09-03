//
//  SupplierLogo.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct SupplierLogo {
    var icon: SupplierIcon

    init(icon: SupplierIcon = SupplierIcon()) {
        self.icon = icon
    }
}

extension SupplierLogo: Codable {
    enum SupplierLogoCodingKeys: String, CodingKey {
        case icon
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SupplierLogoCodingKeys.self)

        icon = try container.decodeIfPresent(SupplierIcon.self, forKey: .icon) ?? SupplierIcon()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SupplierLogoCodingKeys.self)

        try container.encodeIfPresent(icon, forKey: .icon)
    }
}


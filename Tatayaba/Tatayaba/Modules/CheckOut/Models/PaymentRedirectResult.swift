//
//  PaymentRedirectResult.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/19/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct PaymentRedirectResult {
    var redirectUrl: String
}

extension PaymentRedirectResult: Codable {
    enum CodingKeys: String, CodingKey {
        case redirectUrl = "redirect_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        redirectUrl = try container.decodeIfPresent(String.self, forKey: .redirectUrl) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(redirectUrl, forKey: .redirectUrl)
    }
}

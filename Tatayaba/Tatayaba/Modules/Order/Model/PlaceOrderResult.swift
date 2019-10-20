//
//  PlaceOrderResult.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/28/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct PlaceOrderResult {
    var orderId: Int
    var redirectUrl: String
}

extension PlaceOrderResult: Codable {
    enum PlaceOrderResultCodingKeys: String, CodingKey {
        case orderId = "order_id"
        case redirectUrl = "redirect_url"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PlaceOrderResultCodingKeys.self)
        orderId = try container.decodeIfPresent(Int.self, forKey: .orderId) ?? 0
        redirectUrl = try container.decodeIfPresent(String.self, forKey: .redirectUrl) ?? ""

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PlaceOrderResultCodingKeys.self)
        try container.encode(orderId, forKey: .orderId)
        try container.encode(redirectUrl, forKey: .redirectUrl)

    }
}

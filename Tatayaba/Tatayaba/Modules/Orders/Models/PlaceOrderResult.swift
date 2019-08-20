//
//  PlaceOrderResult.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/28/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct PlaceOrderResult {
    var orderId: Int
}

extension PlaceOrderResult: Codable {
    enum PlaceOrderResultCodingKeys: String, CodingKey {
        case orderId = "order_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PlaceOrderResultCodingKeys.self)
        orderId = try container.decodeIfPresent(Int.self, forKey: .orderId) ?? 0
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PlaceOrderResultCodingKeys.self)
        try container.encode(orderId, forKey: .orderId)
    }
}

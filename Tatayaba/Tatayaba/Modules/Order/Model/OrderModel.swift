//
//  OrderModel.swift
//  Tatayaba
//
//  Created by Admin on 24/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct OrderModel {
    var identifier: String
    var status: String
    var totalPrice: String

    init() {
        self.identifier = ""
        self.status = ""
        self.totalPrice = ""
    }

}

extension OrderModel: Codable {
    enum UserCodingKeys: String, CodingKey {
        case identifier = "order_id"
        case status
        case totalPrice = "total"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)
        identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        totalPrice = try container.decodeIfPresent(String.self, forKey: .totalPrice) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)
        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(totalPrice, forKey: .totalPrice)
    }
}


struct OrdersResult {
    var orders: [OrderModel]?
}

extension OrdersResult: Codable {
    enum OrderResultCodingKeys: String, CodingKey {
        case orders
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OrderResultCodingKeys.self)
        orders = try container.decodeIfPresent([OrderModel].self, forKey: .orders)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: OrderResultCodingKeys.self)
        try container.encode(orders, forKey: .orders)
    }
}

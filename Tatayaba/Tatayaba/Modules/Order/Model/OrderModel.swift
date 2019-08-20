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
    var subtotal: Double
    var discount: Double
    var subtotalDiscount: Double
    var shippingCost: String

    var shippingCity: String
    var shippingCountry: String
    var shippingPhone: String
    var timestamp: String

    init() {
        self.identifier = ""
        self.status = ""
        self.totalPrice = ""
        self.subtotal = 0.0
        self.discount = 0.0
        self.subtotalDiscount = 0.0
        self.shippingCost = ""
        self.shippingCity = ""
        self.shippingCountry = ""
        self.shippingPhone = ""
        self.timestamp = ""
    }

}

extension OrderModel: Codable {
    enum OrderModelCodingKeys: String, CodingKey {
        case identifier = "order_id"
        case status
        case totalPrice = "total"
        case subtotal
        case discount
        case subtotalDiscount = "subtotal_discount"
        case shippingCost = "shipping_cost"
        case shippingCity = "s_city"
        case shippingCountry = "s_country_descr"
        case shippingPhone = "s_phone"
        case timestamp
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: OrderModelCodingKeys.self)
        identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        totalPrice = try container.decodeIfPresent(String.self, forKey: .totalPrice) ?? ""
        subtotal = try container.decodeIfPresent(Double.self, forKey: .subtotal) ?? 0.0
        discount = try container.decodeIfPresent(Double.self, forKey: .discount) ?? 0.0
        subtotalDiscount = try container.decodeIfPresent(Double.self, forKey: .subtotalDiscount) ?? 0.0
        shippingCost = try container.decodeIfPresent(String.self, forKey: .shippingCost) ?? ""
        shippingCity = try container.decodeIfPresent(String.self, forKey: .shippingCity) ?? ""
        shippingCountry = try container.decodeIfPresent(String.self, forKey: .shippingCountry) ?? ""
        shippingPhone = try container.decodeIfPresent(String.self, forKey: .shippingPhone) ?? ""
        timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp) ?? ""

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: OrderModelCodingKeys.self)
        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(totalPrice, forKey: .totalPrice)
        try container.encodeIfPresent(subtotal, forKey: .subtotal)
        try container.encodeIfPresent(discount, forKey: .discount)
        try container.encodeIfPresent(subtotalDiscount, forKey: .subtotalDiscount)
        try container.encodeIfPresent(shippingCost, forKey: .shippingCost)
        try container.encodeIfPresent(shippingCity, forKey: .shippingCity)
        try container.encodeIfPresent(shippingCountry, forKey: .shippingCountry)
        try container.encodeIfPresent(shippingPhone, forKey: .shippingPhone)
        try container.encodeIfPresent(timestamp, forKey: .timestamp)

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

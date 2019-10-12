//
//  ShippingMethod.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ShippingMethodResult {
    var shippings: [ShippingMethod]?
}

extension ShippingMethodResult: Codable {
    enum ShippingMethodResultCodingKeys: String, CodingKey {
        case shippings
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ShippingMethodResultCodingKeys.self)
        shippings = try container.decodeIfPresent([ShippingMethod].self, forKey: .shippings)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ShippingMethodResultCodingKeys.self)
        try container.encode(shippings, forKey: .shippings)
    }
}


struct ShippingMethod {
    var shippingId: String
    var position: String
    var status: String
    var name: String
    var deliveryTime: String
    var rate: [ShippingRate]

    init(shippingId: String = "", position: String = "", status: String = "", name: String = "", deliveryTime: String = "", rate: [ShippingRate] = [ShippingRate]()) {
        self.shippingId = shippingId
        self.position = position
        self.status = status
        self.name = name
        self.deliveryTime = deliveryTime
        self.rate = rate
    }
}

extension ShippingMethod: Codable {
    enum ShippingMethodCodingKeys: String, CodingKey {
        case shippingId = "shipping_id"
        case position
        case status
        case name = "shipping"
        case deliveryTime = "delivery_time"
        case rate
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ShippingMethodCodingKeys.self)

        shippingId = try container.decodeIfPresent(String.self, forKey: .shippingId) ?? ""
        position = try container.decodeIfPresent(String.self, forKey: .position) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        deliveryTime = try container.decodeIfPresent(String.self, forKey: .deliveryTime) ?? ""
        rate = try container.decodeIfPresent([ShippingRate].self, forKey: .rate) ?? [ShippingRate]()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ShippingMethodCodingKeys.self)

        try container.encodeIfPresent(shippingId, forKey: .shippingId)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(deliveryTime, forKey: .deliveryTime)
        try container.encodeIfPresent(rate, forKey: .rate)
    }
}

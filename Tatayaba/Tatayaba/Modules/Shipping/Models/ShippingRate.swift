//
//  ShippingRate.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/19/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ShippingRate {
    var destinationId: String
    var destination: String
    var status: String

    init(destinationId: String = "", destination: String = "", status: String = "") {
        self.destinationId = destinationId
        self.destination = destination
        self.status = status
    }
}

extension ShippingRate: Codable {
    enum ShippingRateCodingKeys: String, CodingKey {
        case destinationId = "destination_id"
        case destination
        case status
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ShippingRateCodingKeys.self)

        destinationId = try container.decodeIfPresent(String.self, forKey: .destinationId) ?? ""
        destination = try container.decodeIfPresent(String.self, forKey: .destination) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ShippingRateCodingKeys.self)

        try container.encodeIfPresent(destinationId, forKey: .destinationId)
        try container.encodeIfPresent(destination, forKey: .destination)
        try container.encodeIfPresent(status, forKey: .status)
    }
}

//
//  Payment.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct PaymentResult {
    var paymentMethods: [Payment]?
}

extension PaymentResult: Codable {
    enum paymentMethodsResultCodingKeys: String, CodingKey {
        case paymentMethods = "payments"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: paymentMethodsResultCodingKeys.self)
        paymentMethods = try container.decodeIfPresent([Payment].self, forKey: .paymentMethods)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: paymentMethodsResultCodingKeys.self)
        try container.encode(paymentMethods, forKey: .paymentMethods)
    }
}

struct Payment {
    var paymentId: String = ""
    var position: String = ""
    var status: String = ""
    var processorId: String = ""
    var name: String = ""
    var category: String = ""
    var instructions: String = ""

    init(paymentId: String = "", position: String = "", status: String = "", processorId: String = "", name: String = "", category: String = "", instructions: String = "") {
        self.paymentId = paymentId
        self.position = position
        self.status = status
        self.processorId = processorId
        self.name = name
        self.category = category
        self.instructions = instructions
    }
}

extension Payment: Codable {
    enum PaymentCodingKeys: String, CodingKey {
        case paymentId = "shipping_id"
        case position
        case status
        case processorId = "processor_id"
        case name = "payment"
        case category = "payment_category"
        case instructions
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PaymentCodingKeys.self)

        paymentId = try container.decodeIfPresent(String.self, forKey: .paymentId) ?? ""
        position = try container.decodeIfPresent(String.self, forKey: .position) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        processorId = try container.decodeIfPresent(String.self, forKey: .processorId) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        category = try container.decodeIfPresent(String.self, forKey: .category) ?? ""
        instructions = try container.decodeIfPresent(String.self, forKey: .instructions) ?? ""

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: PaymentCodingKeys.self)

        try container.encodeIfPresent(paymentId, forKey: .paymentId)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(processorId, forKey: .processorId)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(instructions, forKey: .instructions)
    }
}

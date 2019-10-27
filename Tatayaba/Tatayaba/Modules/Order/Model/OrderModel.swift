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
    var billingCity: String
    var billingCountry: String
    var shippingPhone: String
    var timestamp: String
    var paymentInfo : PaymentInfo?
    var paymentMethod: PaymentMethod?
//    var products: [Product]
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
        self.billingCity = ""
        self.billingCountry = ""
        self.shippingPhone = ""
        self.timestamp = ""
//        self.products = [Product]()
    }

}

extension OrderModel: Codable {
    enum OrderModelCodingKeys: String, CodingKey {
        case identifier = "order_id"
        case status = "status"
        case totalPrice = "total"
        case subtotal = "subtotal"
        case discount = "discount"
        case subtotalDiscount = "subtotal_discount"
        case shippingCost = "shipping_cost"
        case shippingCity = "s_city"
        case shippingCountry = "s_country_descr"
        case billingCity = "b_city"
        case billingCountry = "b_country_descr"
        case shippingPhone = "s_phone"
        case timestamp = "timestamp"
        case paymentInfo = "payment_info"
        case paymentMethod = "payment_method"
//        case products
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
        billingCity = try container.decodeIfPresent(String.self, forKey: .billingCity) ?? ""
        billingCountry = try container.decodeIfPresent(String.self, forKey: .billingCountry) ?? ""
        shippingPhone = try container.decodeIfPresent(String.self, forKey: .shippingPhone) ?? ""
        timestamp = try container.decodeIfPresent(String.self, forKey: .timestamp) ?? ""
        paymentInfo = try container.decodeIfPresent(PaymentInfo.self, forKey: .paymentInfo)
        paymentMethod = try container.decodeIfPresent(PaymentMethod.self, forKey: .paymentMethod)
//        products = try container.decodeIfPresent([Product].self, forKey: .products) ?? [Product]()
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
        try container.encodeIfPresent(billingCity, forKey: .billingCity)
        try container.encodeIfPresent(billingCountry, forKey: .billingCountry)
        try container.encodeIfPresent(shippingPhone, forKey: .shippingPhone)
        try container.encodeIfPresent(timestamp, forKey: .timestamp)
        try container.encodeIfPresent(paymentInfo, forKey: .paymentInfo)
        try container.encodeIfPresent(paymentMethod, forKey: .paymentMethod)
//        try container.encodeIfPresent(products, forKey: .products)
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

struct PaymentInfo : Codable {
    
    let authorizationNumber : String?
    let knetPaymentId : String?
    let knetStatus : String?
    let orderStatus : String?
    let postDate : String?
    let referenceNumber : String?
    let trackId : String?
    let transactionId : String?
    
    
    enum CodingKeys: String, CodingKey {
        case authorizationNumber = "authorization_number"
        case knetPaymentId = "knet_payment_id"
        case knetStatus = "knet_status"
        case orderStatus = "order_status"
        case postDate = "post_date"
        case referenceNumber = "reference_number"
        case trackId = "track_id"
        case transactionId = "transaction_id"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        authorizationNumber = try values.decodeIfPresent(String.self, forKey: .authorizationNumber)
        knetPaymentId = try values.decodeIfPresent(String.self, forKey: .knetPaymentId)
        knetStatus = try values.decodeIfPresent(String.self, forKey: .knetStatus)
        orderStatus = try values.decodeIfPresent(String.self, forKey: .orderStatus)
        postDate = try values.decodeIfPresent(String.self, forKey: .postDate)
        referenceNumber = try values.decodeIfPresent(String.self, forKey: .referenceNumber)
        trackId = try values.decodeIfPresent(String.self, forKey: .trackId)
        transactionId = try values.decodeIfPresent(String.self, forKey: .transactionId)
    }
}

//
//  ConvertedCurrency.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 11/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ConvertedCurrency {
    var shippingCharge: String
    var products: [ConvertedProduct]
//    var toCurrency: String
    var surCharge: String
    var currencyCode: String
    var cartTotalThreshold: String
    var vatAmount: String
    
    init(shippingCharge: String = "", surCharge: String = "", currencyCode: String = "", cartTotalThreshold: String = "", vatAmount: String = "", products: [ConvertedProduct]) {
        self.shippingCharge = shippingCharge
        self.products = products
        self.surCharge = surCharge
        self.currencyCode = currencyCode
        self.cartTotalThreshold = cartTotalThreshold
        self.vatAmount = vatAmount
    }
}

extension ConvertedCurrency: Codable {
    enum CodingKeys: String, CodingKey {
        case shippingCharge = "shipping_charge"
        case products
        case surCharge = "sur_charge"
        case currencyCode = "currency_code"
        case cartTotalThreshold = "threshold_limit"
        case vatAmount = "vat_amount"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        shippingCharge = try container.decodeIfPresent(String.self, forKey: .shippingCharge) ?? ""
        products = try container.decodeIfPresent([ConvertedProduct].self, forKey: .products) ?? [ConvertedProduct]()
        surCharge = try container.decodeIfPresent(String.self, forKey: .surCharge) ?? ""
        currencyCode = try container.decodeIfPresent(String.self, forKey: .currencyCode) ?? ""
        cartTotalThreshold = try container.decodeIfPresent(String.self, forKey: .cartTotalThreshold) ?? ""
        vatAmount = try container.decodeIfPresent(String.self, forKey: .vatAmount) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encodeIfPresent(shippingCharge, forKey: .shippingCharge)
        try container.encodeIfPresent(products, forKey: .products)
        try container.encodeIfPresent(surCharge, forKey: .surCharge)
        try container.encodeIfPresent(currencyCode, forKey: .currencyCode)
        try container.encodeIfPresent(cartTotalThreshold, forKey: .cartTotalThreshold)
        try container.encodeIfPresent(vatAmount, forKey: .vatAmount)
    }
}

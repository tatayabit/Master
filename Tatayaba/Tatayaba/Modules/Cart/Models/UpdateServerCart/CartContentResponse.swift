//
//  CartContentResponse.swift
//  Tatayaba
//
//  Created by new on 12/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation
struct CartContentResponse : Codable{
    var products: [Product]?
    var tax_subtotal: Double = 0.0
    var discount: Double = 0.0
    var total: Double = 0.0
    var amount: Double = 0.0
    var original_subtotal: Double = 0.0
    var display_subtotal: Double = 0.0
    var subtotal: Double = 0.0
    var use_discount: Bool = false
    var shipping_required: Bool = false
    var company_shipping_failed: Bool = false
    var shipping_failed: Bool = false
    var stored_taxes: String = ""
    var shipping_cost: Double = 0.0
    var display_shipping_cost: Double = 0.0
    var recalculate: Bool = false
    var options_style: String = ""
    var calculate_shipping: Bool = false
    var no_promotions: Bool = false
    var subtotal_discount: Double = 0.0
    var has_coupons: Bool = false
    var total_formatted: CurrencyFormatted?
    var subtotal_formatted: CurrencyFormatted?
    var discount_formatted: CurrencyFormatted?
    var subtotal_discount_formatted: CurrencyFormatted?
    var shipping_cost_formatted: CurrencyFormatted?
    var tax_subtotal_formatted: CurrencyFormatted?
    var display_subtotal_formatted: CurrencyFormatted?
    var display_shipping_cost_formatted: CurrencyFormatted?
    var promotionData : PromotionData?
    
    enum CartContentCodingKeys: String, CodingKey {
        case products
        case tax_subtotal = "tax_subtotal"
        case discount = "discount"
        case total = "total"
        case amount = "amount"
        case original_subtotal = "original_subtotal"
        case display_subtotal = "display_subtotal"
        case subtotal = "subtotal"
        case total_formatted
        case subtotal_formatted
        case discount_formatted
        case subtotal_discount_formatted
        case shipping_cost_formatted
        case tax_subtotal_formatted
        case display_subtotal_formatted
        case display_shipping_cost_formatted
        
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CartContentCodingKeys.self)
        
        products = try container.decodeIfPresent([Product].self, forKey: .products) ?? [Product]()
        tax_subtotal = try container.decodeIfPresent(Double.self, forKey: .tax_subtotal) ?? 0.0
        discount = try container.decodeIfPresent(Double.self, forKey: .discount) ?? 0.0
        total = try container.decodeIfPresent(Double.self, forKey: .total) ?? 0.0
        amount = try container.decodeIfPresent(Double.self, forKey: .amount) ?? 0.0
        original_subtotal = try container.decodeIfPresent(Double.self, forKey: .original_subtotal) ?? 0.0
        display_subtotal = try container.decodeIfPresent(Double.self, forKey: .display_subtotal) ?? 0.0
        subtotal = try container.decodeIfPresent(Double.self, forKey: .subtotal) ?? 0.0
        total_formatted = try container.decodeIfPresent(CurrencyFormatted.self, forKey: .total_formatted)
        subtotal_formatted = try container.decodeIfPresent(CurrencyFormatted.self, forKey: .subtotal_formatted)
        discount_formatted = try container.decodeIfPresent(CurrencyFormatted.self, forKey: .discount_formatted)
        subtotal_discount_formatted = try container.decodeIfPresent(CurrencyFormatted.self, forKey: .subtotal_discount_formatted)
        shipping_cost_formatted = try container.decodeIfPresent(CurrencyFormatted.self, forKey: .shipping_cost_formatted)
        tax_subtotal_formatted = try container.decodeIfPresent(CurrencyFormatted.self, forKey: .tax_subtotal_formatted)
        display_subtotal_formatted = try container.decodeIfPresent(CurrencyFormatted.self, forKey: .display_subtotal_formatted)
        display_shipping_cost_formatted = try container.decodeIfPresent(CurrencyFormatted.self, forKey: .display_shipping_cost_formatted)
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CartContentCodingKeys.self)

        try container.encodeIfPresent(products, forKey: .products)
    }
}

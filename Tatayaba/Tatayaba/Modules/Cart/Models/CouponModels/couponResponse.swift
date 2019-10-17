//
//    couponResponse.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct couponResponse : Decodable {
    
    let amount : Int?
    let calculateShipping : Bool?
    let chosenShipping : [String]?
    let companyShippingFailed : Bool?
    let coupons : [String]?
    
    let discount : Int?
    
    let displayShippingCost : Int?
    let displaySubtotal : Int?
    let freeShipping : [String]?
    let hasCoupons : Bool?
    let noPromotions : Bool?
    let optionsStyle : String?
    let originalSubtotal : Int?
    let promotions : [String]?
    let recalculate : Bool?
    let shipping : [String]?
    let shippingCost : Int?
    let shippingFailed : Bool?
    let shippingRequired : Bool?
    let storedTaxes : String?
    let subtotal : Int?
    let subtotalDiscount : Int?
    let taxSubtotal : Int?
    let taxSummary : [String]?
    let taxes : [String]?
    let total : Int?
    let useDiscount : Bool?
    
    
    enum CodingKeys: String, CodingKey {
        case amount = "amount"
        case calculateShipping = "calculate_shipping"
        case chosenShipping = "chosen_shipping"
        case companyShippingFailed = "company_shipping_failed"
        case coupons = "coupons"
        case defaultLocation
        case discount = "discount"
        case discountFormatted
        case displayShippingCost = "display_shipping_cost"
        case displayShippingCostFormatted
        case displaySubtotal = "display_subtotal"
        case displaySubtotalFormatted
        case freeShipping = "free_shipping"
        case hasCoupons = "has_coupons"
        case noPromotions = "no_promotions"
        case optionsStyle = "options_style"
        case originalSubtotal = "original_subtotal"
        case payments
        case productGroups = "product_groups"
        case products
        case promotions = "promotions"
        case recalculate = "recalculate"
        case shipping = "shipping"
        case shippingCost = "shipping_cost"
        case shippingCostFormatted
        case shippingFailed = "shipping_failed"
        case shippingRequired = "shipping_required"
        case storedTaxes = "stored_taxes"
        case subtotal = "subtotal"
        case subtotalDiscount = "subtotal_discount"
        case subtotalDiscountFormatted
        case subtotalFormatted
        case taxSubtotal = "tax_subtotal"
        case taxSubtotalFormatted
        case taxSummary = "tax_summary"
        case taxes = "taxes"
        case total = "total"
        case totalFormatted
        case useDiscount = "use_discount"
        case userData
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        amount = try values.decodeIfPresent(Int.self, forKey: .amount)
        calculateShipping = try values.decodeIfPresent(Bool.self, forKey: .calculateShipping)
        chosenShipping = try values.decodeIfPresent([String].self, forKey: .chosenShipping)
        companyShippingFailed = try values.decodeIfPresent(Bool.self, forKey: .companyShippingFailed)
        coupons = try values.decodeIfPresent([String].self, forKey: .coupons)
        discount = try values.decodeIfPresent(Int.self, forKey: .discount)
        displayShippingCost = try values.decodeIfPresent(Int.self, forKey: .displayShippingCost)
        displaySubtotal = try values.decodeIfPresent(Int.self, forKey: .displaySubtotal)
        
        freeShipping = try values.decodeIfPresent([String].self, forKey: .freeShipping)
        hasCoupons = try values.decodeIfPresent(Bool.self, forKey: .hasCoupons)
        noPromotions = try values.decodeIfPresent(Bool.self, forKey: .noPromotions)
        optionsStyle = try values.decodeIfPresent(String.self, forKey: .optionsStyle)
        originalSubtotal = try values.decodeIfPresent(Int.self, forKey: .originalSubtotal)
        
        promotions = try values.decodeIfPresent([String].self, forKey: .promotions)
        recalculate = try values.decodeIfPresent(Bool.self, forKey: .recalculate)
        shipping = try values.decodeIfPresent([String].self, forKey: .shipping)
        shippingCost = try values.decodeIfPresent(Int.self, forKey: .shippingCost)
        
        shippingFailed = try values.decodeIfPresent(Bool.self, forKey: .shippingFailed)
        shippingRequired = try values.decodeIfPresent(Bool.self, forKey: .shippingRequired)
        storedTaxes = try values.decodeIfPresent(String.self, forKey: .storedTaxes)
        subtotal = try values.decodeIfPresent(Int.self, forKey: .subtotal)
        subtotalDiscount = try values.decodeIfPresent(Int.self, forKey: .subtotalDiscount)
        
        taxSubtotal = try values.decodeIfPresent(Int.self, forKey: .taxSubtotal)
        
        taxSummary = try values.decodeIfPresent([String].self, forKey: .taxSummary)
        taxes = try values.decodeIfPresent([String].self, forKey: .taxes)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
        
        useDiscount = try values.decodeIfPresent(Bool.self, forKey: .useDiscount)
    }
    
    
}

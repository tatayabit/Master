//
//  CartContentResponse.swift
//  Tatayaba
//
//  Created by new on 12/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct CartContentResponse : Codable {

        let products : [Product]?
        let taxSubtotal : Int?
        let discount : Int?
        let total : Float?
        let amount : Int?
        let originalSubtotal : Float?
        let displaySubtotal : Float?
        let subtotal : Float?
        let useDiscount : Bool?
        let shippingRequired : Bool?
        let companyShippingFailed : Bool?
        let shippingFailed : Bool?
        let storedTaxes : String?
        let shippingCost : Int?
        let displayShippingCost : Int?
        let recalculate : Bool?
        let calculateShipping : Bool?
        let noPromotions : Bool?
        let subtotalDiscount : Int?
        let hasCoupons : Bool?
        let payments : Payment?
        let totalFormatted : BasePriceFormatted?
        let subtotalFormatted : BasePriceFormatted?
        let discountFormatted : BasePriceFormatted?
        let subtotalDiscountFormatted : BasePriceFormatted?
        let shippingCostFormatted : BasePriceFormatted?
        let taxSubtotalFormatted : BasePriceFormatted?
        let displaySubtotalFormatted : BasePriceFormatted?
        let displayShippingCostFormatted : BasePriceFormatted?
    
//        let coupons : [AnyObject]?
//    let appliedPromotions : [AnyObject]?
//    let userData : [AnyObject]?
//        let defaultLocation : DefaultLocation?
//        let shipping : [AnyObject]?
//        let chosenShipping : [AnyObject]?
//        let taxSummary : [AnyObject]?
//        let taxes : [AnyObject]?
//        let promotions : [AnyObject]?
//        let freeShipping : [AnyObject]?
//    let optionsStyle : String?
    
        enum CodingKeys: String, CodingKey {
                case products = "products"
                case taxSubtotal = "tax_subtotal"
                case discount = "discount"
                case total = "total"
                case amount = "amount"
                case originalSubtotal = "original_subtotal"
                case displaySubtotal = "display_subtotal"
                case subtotal = "subtotal"
                case useDiscount = "use_discount"
                case shippingRequired = "shipping_required"
                case companyShippingFailed = "company_shipping_failed"
                case shippingFailed = "shipping_failed"
                case storedTaxes = "stored_taxes"
                case shippingCost = "shipping_cost"
                case displayShippingCost = "display_shipping_cost"
                case recalculate = "recalculate"
                
                case calculateShipping = "calculate_shipping"
                case noPromotions = "no_promotions"
                case subtotalDiscount = "subtotal_discount"
                case hasCoupons = "has_coupons"
                
                case payments = "payments"
                case totalFormatted = "total_formatted"
                case subtotalFormatted = "subtotal_formatted"
                case discountFormatted = "discount_formatted"
                case subtotalDiscountFormatted = "subtotal_discount_formatted"
                case shippingCostFormatted = "shipping_cost_formatted"
                case taxSubtotalFormatted = "tax_subtotal_formatted"
                case displaySubtotalFormatted = "display_subtotal_formatted"
                case displayShippingCostFormatted = "display_shipping_cost_formatted"
            
            
//            case coupons = "coupons"
//            case appliedPromotions = "applied_promotions"
//            case freeShipping = "free_shipping"
//            case productGroups = "product_groups"
//            case shipping = "shipping"
//            case chosenShipping = "chosen_shipping"
//            case taxSummary = "tax_summary"
//            case taxes = "taxes"
//            case promotions = "promotions"
//            case defaultLocation = "default_location"
//            case userData = "user_data"
//            case optionsStyle = "options_style"
        }
    
        init(from decoder: Decoder) throws {
                let values = try decoder.container(keyedBy: CodingKeys.self)
                products = try values.decodeIfPresent([Product].self, forKey: .products)
                taxSubtotal = try values.decodeIfPresent(Int.self, forKey: .taxSubtotal)
                discount = try values.decodeIfPresent(Int.self, forKey: .discount)
                total = try values.decodeIfPresent(Float.self, forKey: .total)
                amount = try values.decodeIfPresent(Int.self, forKey: .amount)
                originalSubtotal = try values.decodeIfPresent(Float.self, forKey: .originalSubtotal)
                displaySubtotal = try values.decodeIfPresent(Float.self, forKey: .displaySubtotal)
                subtotal = try values.decodeIfPresent(Float.self, forKey: .subtotal)
                useDiscount = try values.decodeIfPresent(Bool.self, forKey: .useDiscount)
                shippingRequired = try values.decodeIfPresent(Bool.self, forKey: .shippingRequired)
                companyShippingFailed = try values.decodeIfPresent(Bool.self, forKey: .companyShippingFailed)
                shippingFailed = try values.decodeIfPresent(Bool.self, forKey: .shippingFailed)
                storedTaxes = try values.decodeIfPresent(String.self, forKey: .storedTaxes)
                shippingCost = try values.decodeIfPresent(Int.self, forKey: .shippingCost)
                displayShippingCost = try values.decodeIfPresent(Int.self, forKey: .displayShippingCost)
                recalculate = try values.decodeIfPresent(Bool.self, forKey: .recalculate)
                calculateShipping = try values.decodeIfPresent(Bool.self, forKey: .calculateShipping)
                noPromotions = try values.decodeIfPresent(Bool.self, forKey: .noPromotions)
                subtotalDiscount = try values.decodeIfPresent(Int.self, forKey: .subtotalDiscount)
                hasCoupons = try values.decodeIfPresent(Bool.self, forKey: .hasCoupons)
                payments = try values.decodeIfPresent(Payment.self, forKey: .payments)
                totalFormatted = try values.decodeIfPresent(BasePriceFormatted.self, forKey: .totalFormatted)
                subtotalFormatted = try values.decodeIfPresent(BasePriceFormatted.self, forKey: .subtotalFormatted)
                discountFormatted = try values.decodeIfPresent(BasePriceFormatted.self, forKey: .discountFormatted)
                subtotalDiscountFormatted = try values.decodeIfPresent(BasePriceFormatted.self, forKey: .subtotalDiscountFormatted)
                shippingCostFormatted = try values.decodeIfPresent(BasePriceFormatted.self, forKey: .shippingCostFormatted)
                taxSubtotalFormatted = try values.decodeIfPresent(BasePriceFormatted.self, forKey: .taxSubtotalFormatted)
                displaySubtotalFormatted = try values.decodeIfPresent(BasePriceFormatted.self, forKey: .displaySubtotalFormatted)
                displayShippingCostFormatted = try values.decodeIfPresent(BasePriceFormatted.self, forKey: .displayShippingCostFormatted)
            
            
//            coupons = try values.decodeIfPresent([AnyObject].self, forKey: .coupons)
//             promotions = try values.decodeIfPresent([AnyObject].self, forKey: .promotions)
//            appliedPromotions = try values.decodeIfPresent([AnyObject].self, forKey: .appliedPromotions)
//            userData = try values.decodeIfPresent([AnyObject].self, forKey: .userData)
//            defaultLocation = DefaultLocation(from: decoder)
//            freeShipping = try values.decodeIfPresent([AnyObject].self, forKey: .freeShipping)
//                           optionsStyle = try values.decodeIfPresent(String.self, forKey: .optionsStyle)
//            productGroups = try values.decodeIfPresent([ProductGroup].self, forKey: .productGroups)
//            shipping = try values.decodeIfPresent([AnyObject].self, forKey: .shipping)
//            chosenShipping = try values.decodeIfPresent([AnyObject].self, forKey: .chosenShipping)
//            taxSummary = try values.decodeIfPresent([AnyObject].self, forKey: .taxSummary)
//            taxes = try values.decodeIfPresent([AnyObject].self, forKey: .taxes)
//
        }

}

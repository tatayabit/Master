//
//	Shipping.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Shipping : Codable {

	let deliveryTime : String?
	let disablePaymentIds : [String]?
	let name : String?
	let perUnit : String?
	let rateType : String?
    var rateValue : String?
	let shippingId : String?


	enum CodingKeys: String, CodingKey {
		case deliveryTime = "delivery_time"
		case disablePaymentIds = "disable_payment_ids"
		case name = "name"
		case perUnit = "per_unit"
		case rateType = "rate_type"
		case rateValue = "rate_value"
		case shippingId = "shipping_id"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		deliveryTime = try values.decodeIfPresent(String.self, forKey: .deliveryTime)
		disablePaymentIds = try values.decodeIfPresent([String].self, forKey: .disablePaymentIds)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		perUnit = try values.decodeIfPresent(String.self, forKey: .perUnit)
		rateType = try values.decodeIfPresent(String.self, forKey: .rateType)
		rateValue = try values.decodeIfPresent(String.self, forKey: .rateValue)
		shippingId = try values.decodeIfPresent(String.self, forKey: .shippingId)
	}


}

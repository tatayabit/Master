//
//	TaxAndShippingResponse.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct TaxAndShippingResponse: Decodable {

	let paymentMethods : [PaymentMethod]?
	let shipping : Shipping?
	let tax : Tax?


	enum CodingKeys: String, CodingKey {
		case paymentMethods = "payment_methods"
		case shipping
		case tax
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		paymentMethods = try values.decodeIfPresent([PaymentMethod].self, forKey: .paymentMethods)
        shipping = try values.decodeIfPresent(Shipping.self, forKey: .shipping)
        tax = try values.decodeIfPresent(Tax.self, forKey: .tax)
	}


}

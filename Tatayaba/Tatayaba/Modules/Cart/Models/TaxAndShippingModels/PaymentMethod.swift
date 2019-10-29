//
//	PaymentMethod.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct PaymentMethod : Codable {

	let descriptionField : String?
	let fSurcharge : String?
	let image : PaymentImage?
	let pSurcharge : String?
	let payment : String?
	let paymentId : String?
	let surchargeTitle : String?


	enum CodingKeys: String, CodingKey {
		case descriptionField = "description"
		case fSurcharge = "f_surcharge"
		case image
		case pSurcharge = "p_surcharge"
		case payment = "payment"
		case paymentId = "payment_id"
		case surchargeTitle = "surcharge_title"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
		fSurcharge = try values.decodeIfPresent(String.self, forKey: .fSurcharge)
		image = try values.decodeIfPresent(PaymentImage.self, forKey: .image)
		pSurcharge = try values.decodeIfPresent(String.self, forKey: .pSurcharge)
		payment = try values.decodeIfPresent(String.self, forKey: .payment)
		paymentId = try values.decodeIfPresent(String.self, forKey: .paymentId)
		surchargeTitle = try values.decodeIfPresent(String.self, forKey: .surchargeTitle)
	}


}

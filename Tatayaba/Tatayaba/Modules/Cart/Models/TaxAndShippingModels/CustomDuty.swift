//
//	CustomDuty.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CustomDuty : Codable {

	let cartTotalThreshold : String?
	let type : String?
	let value : String?


	enum CodingKeys: String, CodingKey {
		case cartTotalThreshold = "cart_total_threshold"
		case type = "type"
		case value = "value"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cartTotalThreshold = try values.decodeIfPresent(String.self, forKey: .cartTotalThreshold)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		value = try values.decodeIfPresent(String.self, forKey: .value)
	}


}
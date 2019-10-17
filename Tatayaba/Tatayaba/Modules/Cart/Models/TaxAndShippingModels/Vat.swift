//
//	Vat.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Vat : Codable {

	let type : String?
	let value : String?


	enum CodingKeys: String, CodingKey {
		case type = "type"
		case value = "value"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		value = try values.decodeIfPresent(String.self, forKey: .value)
	}


}
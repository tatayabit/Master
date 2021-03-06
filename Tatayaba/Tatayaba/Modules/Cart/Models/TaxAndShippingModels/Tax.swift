//
//	Tax.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Tax : Codable {

    var customDuties : CustomDuty?
	let vat : Vat?


	enum CodingKeys: String, CodingKey {
		case customDuties = "custom_duties"
		case vat
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        
		customDuties = try values.decodeIfPresent(CustomDuty.self, forKey: .customDuties)
		vat = try values.decodeIfPresent(Vat.self, forKey: .vat)
	}


}

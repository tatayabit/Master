//
//	Vat.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Vat : Codable {

	let type : String?
    var value : String?


	enum CodingKeys: String, CodingKey {
		case type = "type"
		case value = "value"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		type = try values.decodeIfPresent(String.self, forKey: .type)
        var vatValue = ""
        if let vatValueString = try? values.decode(String.self, forKey: .value) {
            vatValue = vatValueString
        } else if let vatValueInt = try? values.decode(Int.self, forKey: .value) {
            vatValue = "\(vatValueInt)"
        }
        value = vatValue
	}


}

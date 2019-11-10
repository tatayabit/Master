//
//	Currency.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Currency : Codable {

	let after : String?
	let coefficient : String?
	let countriesList : String?
	let currencyCode : String?
	let currencyId : String?
	let decimals : String?
	let decimalsSeparator : String?
	let descriptionField : String?
	let isPrimary : String?
	let position : String?
	let status : String?
	let symbol : String?
	let thousandsSeparator : String?


	enum CodingKeys: String, CodingKey {
		case after = "after"
		case coefficient = "coefficient"
		case countriesList = "countries_list"
		case currencyCode = "currency_code"
		case currencyId = "currency_id"
		case decimals = "decimals"
		case decimalsSeparator = "decimals_separator"
		case descriptionField = "description"
		case isPrimary = "is_primary"
		case position = "position"
		case status = "status"
		case symbol = "symbol"
		case thousandsSeparator = "thousands_separator"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		after = try values.decodeIfPresent(String.self, forKey: .after)
		coefficient = try values.decodeIfPresent(String.self, forKey: .coefficient)
		countriesList = try values.decodeIfPresent(String.self, forKey: .countriesList)
		currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
		currencyId = try values.decodeIfPresent(String.self, forKey: .currencyId)
		decimals = try values.decodeIfPresent(String.self, forKey: .decimals)
		decimalsSeparator = try values.decodeIfPresent(String.self, forKey: .decimalsSeparator)
		descriptionField = try values.decodeIfPresent(String.self, forKey: .descriptionField)
		isPrimary = try values.decodeIfPresent(String.self, forKey: .isPrimary)
		position = try values.decodeIfPresent(String.self, forKey: .position)
		status = try values.decodeIfPresent(String.self, forKey: .status)
		symbol = try values.decodeIfPresent(String.self, forKey: .symbol)
		thousandsSeparator = try values.decodeIfPresent(String.self, forKey: .thousandsSeparator)
	}


}
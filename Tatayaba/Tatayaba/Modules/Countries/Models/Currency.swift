//
//	Currency.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Currency {

	var after : String
	var coefficient : String
	var countriesList : String
	var currencyCode : String
	var currencyId : String
	var decimals : String
	var decimalsSeparator : String
	var descriptionField : String
	var isPrimary : String
	var position : String
	var status : String
	var symbol : String
	var thousandsSeparator : String
}

extension Currency: Codable {
    
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
           let container = try decoder.container(keyedBy: CodingKeys.self)

//           code = try container.decodeIfPresent(String.self, forKey: .code) ?? ""
//           name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        
        
            after = try container.decodeIfPresent(String.self, forKey: .after) ?? ""
            coefficient = try container.decodeIfPresent(String.self, forKey: .coefficient) ?? ""
            countriesList = try container.decodeIfPresent(String.self, forKey: .countriesList) ?? ""
            currencyCode = try container.decodeIfPresent(String.self, forKey: .currencyCode) ?? ""
            currencyId = try container.decodeIfPresent(String.self, forKey: .currencyId) ?? ""
            decimals = try container.decodeIfPresent(String.self, forKey: .decimals) ?? ""
            decimalsSeparator = try container.decodeIfPresent(String.self, forKey: .decimalsSeparator) ?? ""
            descriptionField = try container.decodeIfPresent(String.self, forKey: .descriptionField) ?? ""
            isPrimary = try container.decodeIfPresent(String.self, forKey: .isPrimary) ?? ""
            position = try container.decodeIfPresent(String.self, forKey: .position) ?? ""
            status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
            symbol = try container.decodeIfPresent(String.self, forKey: .symbol) ?? ""
            thousandsSeparator = try container.decodeIfPresent(String.self, forKey: .thousandsSeparator) ?? ""
       }

       func encode(to encoder: Encoder) throws {
           var container = encoder.container(keyedBy: CodingKeys.self)

           try container.encodeIfPresent(after, forKey: .after)
           try container.encodeIfPresent(coefficient, forKey: .coefficient)
           try container.encodeIfPresent(countriesList, forKey: .countriesList)
           try container.encodeIfPresent(currencyCode, forKey: .currencyCode)
           try container.encodeIfPresent(currencyId, forKey: .currencyId)
           try container.encodeIfPresent(decimals, forKey: .decimals)
           try container.encodeIfPresent(decimalsSeparator, forKey: .decimalsSeparator)
           try container.encodeIfPresent(descriptionField, forKey: .descriptionField)
           try container.encodeIfPresent(isPrimary, forKey: .isPrimary)
           try container.encodeIfPresent(position, forKey: .position)
           try container.encodeIfPresent(status, forKey: .status)
           try container.encodeIfPresent(symbol, forKey: .symbol)
           try container.encodeIfPresent(thousandsSeparator, forKey: .thousandsSeparator)
       }
}

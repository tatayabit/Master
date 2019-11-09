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
        var cartTotalThresholdValue = ""
        if let cartTotalThresholdValueString = try? values.decode(String.self, forKey: .cartTotalThreshold) {
            cartTotalThresholdValue = cartTotalThresholdValueString
        } else if let cartTotalThresholdValueInt = try? values.decode(Int.self, forKey: .cartTotalThreshold) {
            cartTotalThresholdValue = "\(cartTotalThresholdValueInt)"
        }
        cartTotalThreshold = cartTotalThresholdValue
        
		type = try values.decodeIfPresent(String.self, forKey: .type)
		var customDutiesValue = ""
        if let customDutiesValueString = try? values.decode(String.self, forKey: .value) {
            customDutiesValue = customDutiesValueString
        } else if let customDutiesValueInt = try? values.decode(Int.self, forKey: .value) {
            customDutiesValue = "\(customDutiesValueInt)"
        }
        value = customDutiesValue
	}


}

//
//	PromotionData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct PromotionData : Codable {

	let bonuses : [Bonuse]?
    let promoName : String?
    let errorMessage: String?

	enum CodingKeys: String, CodingKey {
		case bonuses = "bonuses"
		case promoName = "promo_name"
        case errorMessage = "error"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		bonuses = try values.decodeIfPresent([Bonuse].self, forKey: .bonuses)
		promoName = try values.decodeIfPresent(String.self, forKey: .promoName)
        errorMessage = try values.decodeIfPresent(String.self, forKey: .errorMessage)
	}


}

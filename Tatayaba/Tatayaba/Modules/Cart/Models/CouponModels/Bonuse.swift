//
//    Bonuse.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Bonuse : Codable {

    let bonus : String?
    let discountBonus : String?
    let discountValue : String?


    enum CodingKeys: String, CodingKey {
        case bonus = "bonus"
        case discountBonus = "discount_bonus"
        case discountValue = "discount_value"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        bonus = try values.decodeIfPresent(String.self, forKey: .bonus)
        discountBonus = try values.decodeIfPresent(String.self, forKey: .discountBonus)
        discountValue = try values.decodeIfPresent(String.self, forKey: .discountValue)
    }


}

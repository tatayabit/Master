//
//    CouponResponse.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct CouponResponse : Codable {

    let promotionData : PromotionData?


    enum CodingKeys: String, CodingKey {
        case promotionData = "promotion_data"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        promotionData = try values.decodeIfPresent(PromotionData.self, forKey: .promotionData)
    }
}

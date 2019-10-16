//
//	Image.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct Image : Codable {

	let detailedId : String?
	let icon : Icon?
	let imageId : String?
	let pairId : String?
	let position : String?


	enum CodingKeys: String, CodingKey {
		case detailedId = "detailed_id"
		case icon
		case imageId = "image_id"
		case pairId = "pair_id"
		case position = "position"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		detailedId = try values.decodeIfPresent(String.self, forKey: .detailedId)
		icon = try Icon(from: decoder)
		imageId = try values.decodeIfPresent(String.self, forKey: .imageId)
		pairId = try values.decodeIfPresent(String.self, forKey: .pairId)
		position = try values.decodeIfPresent(String.self, forKey: .position)
	}


}
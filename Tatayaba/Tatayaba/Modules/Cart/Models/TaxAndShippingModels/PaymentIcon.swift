//
//	Icon.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct PaymentIcon : Codable {

	let absolutePath : String?
	let alt : String?
	let httpImagePath : String?
	let httpsImagePath : String?
	let imagePath : String?
	let imageX : String?
	let imageY : String?
	let relativePath : String?


	enum CodingKeys: String, CodingKey {
		case absolutePath = "absolute_path"
		case alt = "alt"
		case httpImagePath = "http_image_path"
		case httpsImagePath = "https_image_path"
		case imagePath = "image_path"
		case imageX = "image_x"
		case imageY = "image_y"
		case relativePath = "relative_path"
	}
	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		absolutePath = try values.decodeIfPresent(String.self, forKey: .absolutePath)
		alt = try values.decodeIfPresent(String.self, forKey: .alt)
		httpImagePath = try values.decodeIfPresent(String.self, forKey: .httpImagePath)
		httpsImagePath = try values.decodeIfPresent(String.self, forKey: .httpsImagePath)
		imagePath = try values.decodeIfPresent(String.self, forKey: .imagePath)
		imageX = try values.decodeIfPresent(String.self, forKey: .imageX)
		imageY = try values.decodeIfPresent(String.self, forKey: .imageY)
		relativePath = try values.decodeIfPresent(String.self, forKey: .relativePath)
	}


}

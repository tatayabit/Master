//
//  Product.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ProductsResult {
    var products: [Product]?
}

extension ProductsResult: Codable {
    enum ProductsResultKeys: String, CodingKey {
        case products
    }
}



struct Product {
    var name: String = ""
    var description: String = ""
    var imageUrl: String = ""
    var offerPrices: Float = 0.00
    var price: Float = 0.00
    var inWishlist: Bool = false
    var identifier: String = ""

    init(name: String = "" , description: String = "", imageUrl: String = "", offerPrices: Float = 0.00, price: Float = 0.00, inWishlist: Bool = false, identifier: String = "") {
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.offerPrices = offerPrices
        self.price = price
        self.inWishlist = inWishlist
        self.identifier = identifier
    }
}

extension Product: Codable {
    enum UserCodingKeys: String, CodingKey {
        case name
        case description
        case imageUrl = "image_url"
        case offerPrices = ""
        case price
        case inWishlist
        case identifier = "product_id"

    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)

        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
        offerPrices = try container.decodeIfPresent(Float.self, forKey: .offerPrices) ?? 0.00
        price = try container.decodeIfPresent(Float.self, forKey: .price) ?? 0.00
        inWishlist = try container.decodeIfPresent(Bool.self, forKey: .inWishlist) ?? false
        identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""

    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(imageUrl, forKey: .imageUrl)
        try container.encode(offerPrices, forKey: .offerPrices)
        try container.encode(price, forKey: .price)
        try container.encode(inWishlist, forKey: .inWishlist)
        try container.encode(identifier, forKey: .identifier)

    }
}

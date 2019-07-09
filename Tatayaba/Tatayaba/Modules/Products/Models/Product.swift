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

    init(name: String, description: String, imageUrl: String, offerPrices: Float, price: Float, inWishlist: Bool) {
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.offerPrices = offerPrices
        self.price = price
        self.inWishlist = inWishlist
    }
}

extension Product: Codable {
    enum UserCodingKeys: String, CodingKey {
        case name
        case description
        case imageUrl = "image_url"

    }
}

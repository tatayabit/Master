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
    enum ProductsResultCodingKeys: String, CodingKey {
        case products
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductsResultCodingKeys.self)
        products = try container.decodeIfPresent([Product].self, forKey: .products)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductsResultCodingKeys.self)
        try container.encode(products, forKey: .products)
    }
}



struct Product {
    var name: String = ""
    var description: String = ""
//    var imageUrl: String
    var offerPrices: Float = 0.00
    var price: String = ""
    var inWishlist: Bool = false
    var identifier: String
    var selectedQuantity = 0
    var status: String
    var mainPair: ProductMainPair


    init(name: String = "" , description: String = "", offerPrices: Float = 0.00, price: String = "", inWishlist: Bool = false, identifier: String = "", status: String = "H", mainPair: ProductMainPair = ProductMainPair()) {
        self.name = name
        self.description = description
//        self.imageUrl = imageUrl
        self.offerPrices = offerPrices
        self.price = price
        self.inWishlist = inWishlist
        self.identifier = identifier
        self.status = status
        self.mainPair = mainPair
    }
}

extension Product: Codable {
    enum ProductCodingKeys: String, CodingKey {
        case name = "product"
        case description
        case imageUrl = "https_image_path"
        case offerPrices = ""
        case price
        case inWishlist
        case identifier = "product_id"
        case status = "status"
        case mainPair = "main_pair"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCodingKeys.self)

        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
//        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
        offerPrices = try container.decodeIfPresent(Float.self, forKey: .offerPrices) ?? 0.00
        price = try container.decodeIfPresent(String.self, forKey: .price) ?? ""
        inWishlist = try container.decodeIfPresent(Bool.self, forKey: .inWishlist) ?? false
//        identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? "H"
        mainPair = try container.decodeIfPresent(ProductMainPair.self, forKey: .mainPair) ?? ProductMainPair()

        var idVal = ""
        if let identifierString = try? container.decode(String.self, forKey: .identifier) {
            idVal = identifierString
        } else if let identifierInt = try? container.decode(Int.self, forKey: .identifier) {
            idVal = "\(identifierInt)"
        }
        identifier = idVal
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductCodingKeys.self)
        
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
//        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
        try container.encodeIfPresent(offerPrices, forKey: .offerPrices)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(inWishlist, forKey: .inWishlist)
        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(mainPair, forKey: .mainPair)
    }
}

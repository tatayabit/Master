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
    var listPrice: String
    var price: String = ""
    var inWishlist: Bool = false
    var identifier: String
    var selectedQuantity = 0
    var status: String
    var mainPair: ProductMainPair
    var supplierName: String
    var productOptions: [ProductOption]
    var maxQuantity: String
    var position: String
    var amount: Int
    var outOfStockActions: String
    
    init(name: String = "", supplierName: String = "", description: String = "", listPrice: String = "", price: String = "", inWishlist: Bool = false, identifier: String = "", status: String = "H", mainPair: ProductMainPair = ProductMainPair(), productOptions: [ProductOption] = [ProductOption](), maxQuantity: String = "0", position: String = "", amount: Int = 0, outOfStockActions: String = "") {
        self.name = name
        self.description = description
//        self.imageUrl = imageUrl
        self.listPrice = listPrice
        self.price = price
        self.inWishlist = inWishlist
        self.identifier = identifier
        self.status = status
        self.mainPair = mainPair
        self.supplierName = supplierName
        self.productOptions = productOptions
        self.maxQuantity = maxQuantity
        self.position = position
        self.amount = amount
        self.outOfStockActions = outOfStockActions
    }
}

extension Product: Codable {
    enum ProductCodingKeys: String, CodingKey {
        case name = "product"
        case description = "full_description"//"meta_description"
        case imageUrl = "https_image_path"
        case listPrice = "list_price"
        case price
        case inWishlist
        case identifier = "product_id"
        case status = "status"
        case mainPair = "main_pair"
        case supplierName = "supplier_name"
        case productOptions = "product_options"
        case maxQuantity = "max_qty"
        case position = "featured_position"
        case amount
        case outOfStockActions = "out_of_stock_actions"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductCodingKeys.self)

        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
//        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
//        price = try container.decodeIfPresent(String.self, forKey: .price) ?? ""
        inWishlist = try container.decodeIfPresent(Bool.self, forKey: .inWishlist) ?? false
//        identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? "H"
        mainPair = try container.decodeIfPresent(ProductMainPair.self, forKey: .mainPair) ?? ProductMainPair()

        supplierName = try container.decodeIfPresent(String.self, forKey: .supplierName) ?? ""
        productOptions = try container.decodeIfPresent([ProductOption].self, forKey: .productOptions) ?? [ProductOption]()
        maxQuantity = try container.decodeIfPresent(String.self, forKey: .maxQuantity) ?? "0"
        position = try container.decodeIfPresent(String.self, forKey: .position) ?? ""
        outOfStockActions = try container.decodeIfPresent(String.self, forKey: .outOfStockActions) ?? ""

        var amountVal = 0
        if let amountString = try container.decodeIfPresent(String.self, forKey: .amount) {
            amountVal = Int(amountString) ?? 0
        } else if let amountInt = try container.decodeIfPresent(Int.self, forKey: .amount) {
            amountVal = Int(amountInt)
        }
        
        amount = amountVal
        
        var idVal = ""
        if let identifierString = try? container.decode(String.self, forKey: .identifier) {
            idVal = identifierString
        } else if let identifierInt = try? container.decode(Int.self, forKey: .identifier) {
            idVal = "\(identifierInt)"
        }
        identifier = idVal
        
        
        var priceVal = ""
        if let priceValString = try? container.decode(String.self, forKey: .price) {
            priceVal = priceValString
        } else if let priceValInt = try? container.decode(Int.self, forKey: .price) {
            priceVal = "\(priceValInt)"
        }
        price = priceVal
        
        var listPriceVal = ""
        if let listPriceValString = try? container.decode(String.self, forKey: .listPrice) {
            listPriceVal = listPriceValString
        } else if let listPriceValInt = try? container.decode(Int.self, forKey: .listPrice) {
            listPriceVal = "\(listPriceValInt)"
        }
        listPrice = listPriceVal
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductCodingKeys.self)
        
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
//        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
        try container.encodeIfPresent(listPrice, forKey: .listPrice)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(inWishlist, forKey: .inWishlist)
        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(mainPair, forKey: .mainPair)
        try container.encodeIfPresent(supplierName, forKey: .supplierName)
        try container.encodeIfPresent(maxQuantity, forKey: .maxQuantity)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(amount, forKey: .amount)

    }
}


extension Product {
    var isInStock: Bool {
        if self.amount > 0 { return true }
        if self.outOfStockActions.lowercased() == "b" {
            return true
        }
        return false
    }
}

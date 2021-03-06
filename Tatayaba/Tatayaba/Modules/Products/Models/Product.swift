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
    var priceBeforeDiscount: String
    var discountPercentage: String
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
    var productStatus: String?
    var hasOptions: Bool
    var is_free_delivery: String
    
    init(name: String = "", supplierName: String = "", description: String = "", priceBeforeDiscount: String = "", discountPercentage: String = "", price: String = "0.00", inWishlist: Bool = false, identifier: String = "", status: String = "H", mainPair: ProductMainPair = ProductMainPair(), productOptions: [ProductOption] = [ProductOption](), maxQuantity: String = "0", position: String = "", amount: Int = 0, outOfStockActions: String = "", productStatus: String = "", hasOptions: Bool = false, is_free_delivery: String = "") {

        self.name = name
        self.description = description
        self.priceBeforeDiscount = priceBeforeDiscount
        self.discountPercentage = discountPercentage
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
        self.productStatus = productStatus
        self.hasOptions = hasOptions
        self.is_free_delivery = is_free_delivery
    }
}

extension Product: Codable {
    enum ProductCodingKeys: String, CodingKey {
        case name = "product"
        case description = "full_description"//"meta_description"
        case imageUrl = "https_image_path"
        case priceBeforeDiscount = "list_price"
        case discountPercentage = "list_discount_prc"
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
        case productStatus = "product_status"
        case hasOptions = "has_options"
        case is_free_delivery = "is_free_delivery"
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
        productStatus = try container.decodeIfPresent(String.self, forKey: .productStatus) ?? ""
        hasOptions = try container.decodeIfPresent(Bool.self, forKey: .hasOptions) ?? false
        is_free_delivery = try container.decodeIfPresent(String.self, forKey: .is_free_delivery) ?? ""
        var amountVal = 0
        do {
            let amountInt = try? container.decodeIfPresent(Int.self, forKey: .amount)
            if let amountInt = amountInt {
                amountVal = amountInt ?? 0
            }
        }
        
        do {
            let amountString = try? container.decodeIfPresent(String.self, forKey: .amount)
            if let amountString = amountString {
                amountVal = Int(amountString ?? "0") ?? 0
            }
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
            priceVal = priceValString.replacingOccurrences(of: ",", with: "")
        } else if let priceValInt = try? container.decode(Float.self, forKey: .price) {
            priceVal = "\(priceValInt)"
        }
        price = priceVal
        
        var priceBeforeDiscountVal = ""
        if let priceBeforeDiscountValString = try? container.decode(String.self, forKey: .priceBeforeDiscount) {
            priceBeforeDiscountVal = priceBeforeDiscountValString.replacingOccurrences(of: ",", with: "")
        } else if let priceBeforeDiscountValInt = try? container.decode(Float.self, forKey: .priceBeforeDiscount) {
            priceBeforeDiscountVal = "\(priceBeforeDiscountValInt)"
        }
        priceBeforeDiscount = priceBeforeDiscountVal
        
        var discountPercentageVal = ""
        if let discountPercentageValString = try? container.decode(String.self, forKey: .discountPercentage) {
            discountPercentageVal = discountPercentageValString.replacingOccurrences(of: ",", with: "")
        } else if let discountPercentageValInt = try? container.decode(Float.self, forKey: .discountPercentage) {
            discountPercentageVal = "\(discountPercentageValInt)"
        }
        discountPercentage = discountPercentageVal
        
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: ProductCodingKeys.self)
        
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(priceBeforeDiscount, forKey: .priceBeforeDiscount)
        try container.encodeIfPresent(discountPercentage, forKey: .discountPercentage)
        try container.encodeIfPresent(price, forKey: .price)
        try container.encodeIfPresent(inWishlist, forKey: .inWishlist)
        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(mainPair, forKey: .mainPair)
        try container.encodeIfPresent(supplierName, forKey: .supplierName)
        try container.encodeIfPresent(maxQuantity, forKey: .maxQuantity)
        try container.encodeIfPresent(position, forKey: .position)
        try container.encodeIfPresent(amount, forKey: .amount)
        try container.encodeIfPresent(productStatus, forKey: .productStatus)
        try container.encodeIfPresent(hasOptions, forKey: .hasOptions)
        try container.encodeIfPresent(is_free_delivery, forKey: .is_free_delivery)
    }
}


extension Product {
    var isInStock: Bool {
        if self.amount > 0 { return true }
        if self.isOutOfStockActionB {
            return true
        }
        return false
    }
    
    var isOutOfStockActionB: Bool {
        return self.outOfStockActions.lowercased() == "b"
    }
}

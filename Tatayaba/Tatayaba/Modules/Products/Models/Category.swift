//
//  Category.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/8/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct CategoriesResult {
    var categories: [Category]?
}

extension CategoriesResult: Codable {
    enum CategoriesResultCodingKeys: String, CodingKey {
        case categories
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoriesResultCodingKeys.self)
        categories = try container.decodeIfPresent([Category].self, forKey: .categories)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CategoriesResultCodingKeys.self)

        try container.encode(categories, forKey: .categories)

    }
}

struct Category {
    var identifier: String = ""
    var parentId: String = ""
    var name: String = ""
    var productCount: String = ""
    var description: String = ""

    init() {}
    
    init(identifier: String, parentId: String, name: String, productCount: String, description: String) {
        self.identifier = identifier
        self.parentId = parentId
        self.name = name
        self.productCount = productCount
        self.description = description
    }
}

extension Category: Codable {
    enum UserCodingKeys: String, CodingKey {
        case identifier = "category_id"
        case parentId = "parent_id"
        case name = "category"
        case productCount = "product_count"
        case description
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)

        identifier = try container.decode(String.self, forKey: .identifier)
        parentId = try container.decode(String.self, forKey: .parentId)
        name = try container.decode(String.self, forKey: .name)
        productCount = try container.decode(String.self, forKey: .productCount)
        description = try container.decode(String.self, forKey: .description)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)

        try container.encode(identifier, forKey: .identifier)
        try container.encode(parentId, forKey: .parentId)
        try container.encode(name, forKey: .name)
        try container.encode(productCount, forKey: .productCount)
        try container.encode(description, forKey: .description)

    }
}

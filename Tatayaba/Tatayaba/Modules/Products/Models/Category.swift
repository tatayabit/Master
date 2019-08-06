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
    var identifier: String
    var parentId: String
    var name: String
    var productCount: String
    var description: String
    var imageUrl: String

    init() {
        self.identifier = ""
        self.parentId = ""
        self.name = ""
        self.productCount = ""
        self.description = ""
        self.imageUrl = ""
    }
    
    init(identifier: String, parentId: String = "", name: String = "", productCount: String = "", description: String = "", imageUrl: String = "") {
        self.identifier = identifier
        self.parentId = parentId
        self.name = name
        self.productCount = productCount
        self.description = description
        self.imageUrl = imageUrl
    }
}

extension Category: Codable {
    enum UserCodingKeys: String, CodingKey {
        case identifier = "category_id"
        case parentId = "parent_id"
        case name = "category"
        case productCount = "product_count"
        case description
        case imageUrl = "https_image_path"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserCodingKeys.self)

        identifier = try container.decodeIfPresent(String.self, forKey: .identifier) ?? ""
        parentId = try container.decodeIfPresent(String.self, forKey: .parentId) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        productCount = try container.decodeIfPresent(String.self, forKey: .productCount) ?? ""
        description = try container.decodeIfPresent(String.self, forKey: .description) ?? ""
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl) ?? ""
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: UserCodingKeys.self)

        try container.encodeIfPresent(identifier, forKey: .identifier)
        try container.encodeIfPresent(parentId, forKey: .parentId)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(productCount, forKey: .productCount)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(imageUrl, forKey: .imageUrl)
    }
}

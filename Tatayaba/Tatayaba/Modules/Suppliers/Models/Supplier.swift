//
//  Supplier.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct SuppliersResult {
    var suppliers: [Supplier]?
}

extension SuppliersResult: Codable {
    enum SuppliersResultCodingKeys: String, CodingKey {
        case suppliers
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SuppliersResultCodingKeys.self)
        suppliers = try container.decodeIfPresent([Supplier].self, forKey: .suppliers) ?? [Supplier]()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SuppliersResultCodingKeys.self)
        try container.encode(suppliers, forKey: .suppliers)
    }
}


struct Supplier {
    var supplierId: String = ""
    var status: String? = ""
    var name: String = ""
    var logo: SupplierLogo?
    var products: [Product]?

    init(supplierId: String = "", status: String = "", name: String = "", logo: SupplierLogo = SupplierLogo(), products: [Product] = [Product]()) {
        self.supplierId = supplierId
        self.status = status
        self.name = name
        self.logo = logo
        self.products = products
    }
    
    init(supplierId: String = "",name: String = "") {
        self.supplierId = supplierId
        self.name = name
    }
}

extension Supplier: Codable {
    enum SupplierCodingKeys: String, CodingKey {
        case supplierId = "supplier_id"
        case status
        case name
        case logo
        case products
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SupplierCodingKeys.self)

        supplierId = try container.decodeIfPresent(String.self, forKey: .supplierId) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        logo = try container.decodeIfPresent(SupplierLogo.self, forKey: .logo) ?? SupplierLogo()
        products = try container.decodeIfPresent([Product].self, forKey: .products) ?? [Product]()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SupplierCodingKeys.self)

        try container.encodeIfPresent(supplierId, forKey: .supplierId)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(logo, forKey: .logo)
        try container.encodeIfPresent(products, forKey: .products)
    }
}


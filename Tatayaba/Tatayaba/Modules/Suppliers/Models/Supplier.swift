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
    var status: String = ""
    var name: String = ""
    var logo: SupplierLogo

    init(supplierId: String = "", status: String = "", name: String = "", logo: SupplierLogo) {
        self.supplierId = supplierId
        self.status = status
        self.name = name
        self.logo = logo
    }
}

extension Supplier: Codable {
    enum SupplierCodingKeys: String, CodingKey {
        case supplierId = "supplier_id"
        case status
        case name = "shipping"
        case logo
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: SupplierCodingKeys.self)

        supplierId = try container.decodeIfPresent(String.self, forKey: .supplierId) ?? ""
        status = try container.decodeIfPresent(String.self, forKey: .status) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        logo = try container.decodeIfPresent(SupplierLogo.self, forKey: .logo) ?? SupplierLogo()
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: SupplierCodingKeys.self)

        try container.encodeIfPresent(supplierId, forKey: .supplierId)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(logo, forKey: .logo)
    }
}


//
//  DeeplinkHandler.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/26/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct DeepLinkModel {
    var type: DeeplinkHandler.DlType
    var id: String
    var title: String
}

struct DeeplinkHandler {

    enum DlType: String {
        case category = "categories", product = "products", supplier = "suppliers", unknown = "unknown"
    }

    var url: String

    //MARK:- Init
    init(urlString: String) {
        self.url = urlString
    }

    //MARK:- Parsing
    func parse() -> DeepLinkModel {

        if !url.isEmpty {
            let components = url.components(separatedBy: "/")
            print("queryComponents: \(components)")
            if components.count > 2 {
                let firstPath = components[1]
                let id = components[2]
                let title = self.getUrlTitle(components: components)
                
                switch firstPath {
                case DlType.category.rawValue:
                    print("type: \(DlType.category.rawValue)")
                    return DeepLinkModel(type: .category, id: id, title: title)
                case DlType.product.rawValue:
                    print("type: \(DlType.product.rawValue)")
                    return DeepLinkModel(type: .product, id: id, title: title)
                case DlType.supplier.rawValue:
                print("type: \(DlType.product.rawValue)")
                return DeepLinkModel(type: .supplier, id: id, title: title)
                default:
                    print("type: unknown")
                }
            }
        }
        return DeepLinkModel(type: .unknown, id: "", title: "")
    }
    
    func getUrlTitle(components: [String]) -> String {
        var title = ""
        if components.count > 3 {
            if components[3].count > 0 {
                title = components[3]
            }
        }
        return title
    }
}

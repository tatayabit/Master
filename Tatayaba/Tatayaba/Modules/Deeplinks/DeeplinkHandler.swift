//
//  DeeplinkHandler.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/26/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct DeeplinkHandler {

    enum DlType: String {
        case category = "categories", product = "products", supplier = "suppliers", unknown = "unknown"
    }

    var url: String
    var type: DlType?

    //MARK:- Init
    init(urlString: String) {
        self.url = urlString
    }

    //MARK:- Parsing
    func parse() -> (DlType, String) {

        if !url.isEmpty {
            let components = url.components(separatedBy: "/")
            print("queryComponents: \(components)")
            if components.count > 2 {
                let firstPath = components[1]
                let id = components[2]
                switch firstPath {
                case DlType.category.rawValue:
                    print("type: \(DlType.category.rawValue)")
                    return (.category, id)
                case DlType.product.rawValue:
                    print("type: \(DlType.product.rawValue)")
                    return (.product, id)
                default:
                    print("type: unknown")
                }
            }
        }
        return (.unknown, "")
    }
}

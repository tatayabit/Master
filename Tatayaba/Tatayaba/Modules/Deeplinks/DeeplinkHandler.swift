//
//  DeeplinkHandler.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/26/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct DeeplinkHandler {

    enum DlType {
        case category, product, supplier
    }

    var url: String
    var type: DlType

    //MARK:- Init
    init(urlString: String, type: DlType) {
        self.url = urlString
        self.type = type
    }

    //MARK:- Parsing
    func parse() {

        if !url.isEmpty {
            let components = url.components(separatedBy: "/")
            print("queryComponents: \(components)")
            switch type {
            case .category:
                print("queryComponents: \(components[1])")
            default:
                print("queryComponents: \(components[1])")
            }
        }
    }
}

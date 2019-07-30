//
//  ProductsEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/7/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum ProductsEndpoint {
    case getProducts
    case getAllCategories
    case getProductsOfCategory(categoryId: String, page: String)
    case getProductFeatures
}


extension ProductsEndpoint: TargetType {
    var environmentBaseURL: String {
        switch UserAPIClient.environment {
        case .production: return "http://dev2%40tatayab.com:E970ASsq0e9GmSJ2EX0BLGvskO2UF841@old.tatayab.com/api/"
        case .qa: return "http://localhost:3000/"
        case .staging: return "http://localhost:3000/"
        }
    }


    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }

    var path: String {
        switch self {
        case .getProducts:
            return "products"
        case .getAllCategories:
            return "categories"
        case .getProductsOfCategory(let categoryId, _):
            return "categories/\(categoryId.urlEscaped)/products"
        case .getProductFeatures:
            return "categories/268/products"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getProducts, .getAllCategories, .getProductsOfCategory, .getProductFeatures:
            return .get
        }
    }


    var sampleData: Data {
        switch self {

        default:
            return Data()
        }
    }

    var task: Task {
        switch self {
        case .getProducts:
            return .requestPlain
        case .getAllCategories:
            return .requestParameters(parameters: [ "items_per_page": 0,
                                                    "status": "A"
                ], encoding: URLEncoding.default)

        case .getProductsOfCategory(_, let page):
            return .requestParameters(parameters: [ "items_per_page": 20,
                                                    "page": page.urlEscaped
                ], encoding: URLEncoding.default)

        case .getProductFeatures:
            return .requestParameters(parameters: [ "items_per_page": 10
                ], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {

        return ["Content-type": "application/json",
                "authorization": "Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }

}

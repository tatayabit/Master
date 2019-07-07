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
}


extension ProductsEndpoint: TargetType {
    var environmentBaseURL: String {
        switch UserAPIClient.environment {
        case .production: return "https://dev2%40tatayab.com:3N11X58I51g9Yzx231g5GSP2E2h6Gqkz@dev2.tatayab.com/api/"
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
        }
    }

    var method: Moya.Method {
        switch self {
        case .getProducts:
            return .post
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
        }
    }

    var headers: [String : String]? {

        return ["Content-type": "application/json",
                "authorization": "Basic ZGV2MkB0YXRheWFiLmNvbTozTjExWDU4STUxZzlZengyMzFnNUdTUDJFMmg2R3Freg=="
        ]
    }

}

//
//  SuppliersEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum SuppliersEndpoint {
    case getSuppliers(page: String)
    case getSupplierDetails(supplierId: String)
}


extension SuppliersEndpoint: TargetType {
    var environmentBaseURL: String {
        switch UserAPIClient.environment {
        case .production: return "http://dev_ios%40tatayab.com:6337M41B30af4Sh7A6006lSq2jabf3M2@dev2.tatayab.com/api/"
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
        case .getSuppliers:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmSuppliers/"
        case .getSupplierDetails(let supplierId):
            let version = "4.0"
            return "\(version.urlEscaped)/TtmSuppliers/\(supplierId.urlEscaped)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getSuppliers, .getSupplierDetails:
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
        case .getSuppliers(let page):
            return .requestParameters(parameters: [
                                                "available_country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
                                                "items_per_page": 20,
                                                "page": page.urlEscaped
            ], encoding: URLEncoding.default)
        case .getSupplierDetails:
//            return .requestPlain
            return .requestParameters(parameters: [
                                                "available_country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw"
            ], encoding: URLEncoding.default)
//            "available_country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw",
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json",
                "authorization": "ZGV2X2lvc0B0YXRheWFiLmNvbTo2MzM3TTQxQjMwYWY0U2g3QTYwMDZsU3EyamFiZjNNMg=="//"Basic ZGV2MkB0YXRheWFiLmNvbTo4OUlPMzlOM1pKTVRKSTcweUdGOVBqQjk5RDhVNTcyOQ=="
        ]
    }

}

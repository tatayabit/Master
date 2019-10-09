//
//  SuppliersEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum SuppliersEndpoint {
    case getSuppliers()
    case getSupplierDetails(supplierId: String)
}


extension SuppliersEndpoint: TargetType {
    var environmentBaseURL: String {
        switch UserAPIClient.environment {
        case .production: return "http://dev2%40tatayab.com:gsh34ps0N2DX5qS3y0P09U220h15HM8T@dev2.tatayab.com/api/"
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
        case .getSuppliers, .getSupplierDetails:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json",
                "authorization": "Basic ZGV2MkB0YXRheWFiLmNvbTo4OUlPMzlOM1pKTVRKSTcweUdGOVBqQjk5RDhVNTcyOQ=="
        ]
    }

}

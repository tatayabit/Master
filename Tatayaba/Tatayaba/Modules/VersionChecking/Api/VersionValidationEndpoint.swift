//
//  VersionValidationEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 11/24/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum VersionValidationEndpoint {
    case getVersionValidation(version: String)
}


extension VersionValidationEndpoint: TargetType {
    var environmentBaseURL: String {
        switch UserAPIClient.environment {
        case .production: return "http://ios_tt%40tatayab.com:21Ju1619GAbm2u1pu0TP4hjyccAL07WP@dev.tatayab.com/api/"
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
        case .getVersionValidation:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmMobileUpgradeChecker"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getVersionValidation:
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
        case .getVersionValidation(let version):
            return .requestParameters(parameters: [
                                                "os": "ios",
                                                "v" : version
            ], encoding: URLEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json",
                "authorization": "ZGV2X2lvc0B0YXRheWFiLmNvbTo2MzM3TTQxQjMwYWY0U2g3QTYwMDZsU3EyamFiZjNNMg=="//"Basic ZGV2MkB0YXRheWFiLmNvbTo4OUlPMzlOM1pKTVRKSTcweUdGOVBqQjk5RDhVNTcyOQ=="
        ]
    }

}

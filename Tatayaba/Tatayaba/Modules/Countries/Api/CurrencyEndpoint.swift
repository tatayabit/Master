//
//  CountriesEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 11/3/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum CurrencyEndpoint {
    case getCurrencies()
}


extension CurrencyEndpoint: TargetType {
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
        case .getCurrencies:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmCurrencies/"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getCurrencies:
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
        case .getCurrencies:
            return .requestPlain
        }
    }

    var headers: [String : String]? {
        return ["Content-type": "application/json",
                "authorization": "ZGV2X2lvc0B0YXRheWFiLmNvbTo2MzM3TTQxQjMwYWY0U2g3QTYwMDZsU3EyamFiZjNNMg=="//"Basic ZGV2MkB0YXRheWFiLmNvbTo4OUlPMzlOM1pKTVRKSTcweUdGOVBqQjk5RDhVNTcyOQ=="
        ]
    }

}

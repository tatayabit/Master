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
        case .production: return BaseUrls.production
        case .dev2: return BaseUrls.dev2
        case .staging: return BaseUrls.staging
        case .dev3: return BaseUrls.dev3
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
       var authKey = ""
        switch UserAPIClient.environment {
        case .production: authKey = Keys.Authorizations.production
        case .dev2: authKey = Keys.Authorizations.dev2
        case .staging: authKey = Keys.Authorizations.staging
        case .dev3: authKey = Keys.Authorizations.dev3
        }
        return ["Content-type": "application/json",
                "authorization": authKey//"Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }

}

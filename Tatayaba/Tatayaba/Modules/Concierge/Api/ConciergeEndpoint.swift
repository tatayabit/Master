//
//  ConciergeEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/24/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum ConciergeEndpoint {
    case uploadConcierge(concierge: Concierge)

}


extension ConciergeEndpoint: TargetType {
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
        case .uploadConcierge:
            let version = "4.0"
            return "\(version.urlEscaped)/TtmConcierge"
        }
    }

    var method: Moya.Method {
        switch self {

        case .uploadConcierge:
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
        case .uploadConcierge(let concierge):
            return .requestParameters(parameters: [ "perfume_name": concierge.perfumeName ,
                                                    "comment": concierge.comment ,
                                                    "cust_name": concierge.customerName ,
                                                    "phone": concierge.phone,
                                                    "country_code": concierge.countryCode,
                                                    "image_data": concierge.imageData
                ], encoding: JSONEncoding.default)
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

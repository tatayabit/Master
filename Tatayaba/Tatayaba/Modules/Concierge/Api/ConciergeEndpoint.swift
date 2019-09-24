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
        case .production: return "http://dev2%40tatayab.com:89IO39N3ZJMTJI70yGF9PjB99D8U5729@dev2.tatayab.com/api/"
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
        return ["Content-type": "application/json",
                "authorization": "Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }

}

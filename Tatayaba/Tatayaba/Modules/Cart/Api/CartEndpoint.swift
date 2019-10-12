//
//  CartEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/8/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum CartEndpoint {
    case applyCoupon(code: String)
}


extension CartEndpoint: TargetType {
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
        case .applyCoupon:
            return "4.0/SraCartContent"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .applyCoupon:
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
        case .applyCoupon(let code):
            return .requestParameters(parameters: [ "coupon_codes": code
                ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        
        return ["Content-type": "application/json",
                "authorization": "Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }
    
}
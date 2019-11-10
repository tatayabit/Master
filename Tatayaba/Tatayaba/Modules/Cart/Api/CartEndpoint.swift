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
    case getTaxAndShipping(countryCode: String)
}


extension CartEndpoint: TargetType {
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
        case .applyCoupon:
            return "4.0/TtmOrders"
        case .getTaxAndShipping:
            return "4.0/TtmCartConfigData/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .applyCoupon:
            return .get
        case .getTaxAndShipping:
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
        case .applyCoupon(let code):
            return .requestParameters(parameters: [ "coupon_code": code
                ], encoding: URLEncoding.queryString)
        case .getTaxAndShipping:
            return .requestParameters(parameters: [ "country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw"
                ], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        
        return ["Content-type": "application/json",
                "authorization": "Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }
    
}

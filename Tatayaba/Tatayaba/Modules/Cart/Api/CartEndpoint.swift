//
//  CartEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/8/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum CartEndpoint {
    case applyCoupon(parameters: [String: Any])
    case getTaxAndShipping(countryCode: String)
    case getPricesWithUpdatedCurrency(parameters: [String: Any])
}


extension CartEndpoint: TargetType {
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
        case .applyCoupon:
            return "4.0/TtmOrders"
        case .getTaxAndShipping:
            return "4.0/TtmCartConfigData/"
        case .getPricesWithUpdatedCurrency:
            return "4.0/TtmCurrencies/"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTaxAndShipping:
            return .get
        case .getPricesWithUpdatedCurrency, .applyCoupon:
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
        case .applyCoupon(let parameters):
            
        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getTaxAndShipping:
            return .requestParameters(parameters: [ "country_code": CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw"
                ], encoding: URLEncoding.queryString)
        case .getPricesWithUpdatedCurrency(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        
        return ["Content-type": "application/json",
                "authorization": "Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }
    
}

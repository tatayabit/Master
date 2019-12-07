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

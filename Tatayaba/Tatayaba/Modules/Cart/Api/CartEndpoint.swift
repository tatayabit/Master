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
    case addServerCart(products: [String: Any], userId: String, paymentId: String)
    case deleteAllFromCart(userId: String)
    case deleteItemFromCart(userId: String, cart_id:String)
    case getServerCart(userId: String)
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
        case .addServerCart, .deleteAllFromCart, .deleteItemFromCart , .getServerCart:
            return "4.0/TtmCartContent"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTaxAndShipping, .getServerCart:
            return .get
        case .getPricesWithUpdatedCurrency, .applyCoupon, .addServerCart:
            return .post
        case .deleteAllFromCart, .deleteItemFromCart:
            return .delete
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
        case .getServerCart(let userId):
            return .requestParameters(parameters: [ "user_id": userId], encoding: URLEncoding.queryString)
        case .getPricesWithUpdatedCurrency(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .addServerCart(let products, let userId,let paymentId):
            let params = [
            "user_id": userId,
            "payment_id": paymentId,
            "products": products,
            ] as [String : Any]
            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
            let decoded = String(data: jsonData, encoding: .utf8)!

            print("decoded: \(decoded)")
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .deleteAllFromCart(let userId):
            let params = ["user_id": userId] as [String : Any]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .deleteItemFromCart(let userId, let cart_id):
            let params = ["user_id": userId, "cart_id": cart_id] as [String : Any]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
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

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
    case getTaxAndShipping(countryCode: String,productsID: String)
    case getPricesWithUpdatedCurrency(parameters: [String: Any])
    case updateServerCart(products: [String: Any], userId: String, paymentId: String)
    case deleteAllCart(userId: String)
    case deleteItemFromCart(userId: String,cartId: String)
    case getServerCart(userId: String)
    case updateProductamountAtServerCart(productInCart:String,product_id:String,amount:String, userId: String)
}


extension CartEndpoint: TargetType {
    var environmentBaseURL: String {
        switch CartAPIClient.environment {
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
        case .updateServerCart, .deleteAllCart, .getServerCart, .deleteItemFromCart:
            return "4.0/TtmCartContent"
        case .updateProductamountAtServerCart(let productInCart,_,_,_ ):
            return "4.0/TtmCartContent/\(productInCart)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getTaxAndShipping, .getServerCart:
            return .get
        case .getPricesWithUpdatedCurrency, .applyCoupon, .updateServerCart:
            return .post
        case .deleteAllCart, .deleteItemFromCart:
            return .delete
        case .updateProductamountAtServerCart:
            return .put
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
            

        return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        case .getTaxAndShipping(let countryCode, let productsID):
            //return .requestParameters(parameters: parameters, encoding: StringArrayUrlEncoding())
            let params = [
                "country_code": countryCode,
                "product_ids":productsID
            ] as [String : Any]
            print(params)
            return .requestParameters(parameters: params, encoding: StringArrayUrlEncoding())
            
        case .getPricesWithUpdatedCurrency(let parameters):
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            
        case .updateServerCart(let products, let userId,let paymentId):
            let params = [
            "user_id": userId,
            "payment_id": paymentId,
            "products": products,
            ] as [String : Any]
            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
            let decoded = String(data: jsonData, encoding: .utf8)!

            print("decoded: \(decoded)")
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .deleteAllCart(let userId):
            let params = ["user_id": userId] as [String : Any]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        
        case .getServerCart(let userId):
            let params = ["user_id": userId] as [String : Any]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
            
        case .deleteItemFromCart(let userId, let cartId):
            let params = ["user_id": userId,"cart_id":cartId] as [String : Any]
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .updateProductamountAtServerCart(_, let product_id, let amount, let userId):
            let params = [
                "amount": amount,
                "user_id": userId,
                "product_options": [
//                    "product_id":product_id,
//                    "amount": amount
                ]
                ] as [String : Any]
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
        return [
            "Content-type": "application/json",
                "authorization": authKey//"Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }
    
}

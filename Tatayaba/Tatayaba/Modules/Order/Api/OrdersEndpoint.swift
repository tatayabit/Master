//
//  OrdersEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum OrdersEndpoint {
    case create(products: [String: Any], userId: String, userData: [String: Any]?, paymentId: String, oneClickBuy: Bool, code: String, couponType: String, notes:String)
    case getAllOrders(page: Int)
    case getOrder(orderId: String)

}


extension OrdersEndpoint: TargetType {
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
        case .create:
//            return "4.0/TtmOrders/"
            return "4.0/stores/1/TtmOrders/"
//            api/4.0/stores/1/TtmOrders/
        case .getAllOrders:
            return "4.0/TtmOrders/"
        case .getOrder(let orderId):
            return "4.0/TtmOrders/\(orderId.urlEscaped)"
        }
    }

    var method: Moya.Method {
        switch self {
        case .create:
            return .post
        case .getAllOrders, .getOrder:
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
        case .create(let products, let userId, let userData, let paymentId, let isOneClickBuy, let code, let couponType, let notes):
            var params = [
                "user_id": userId,
                "payment_id": paymentId,
                "shipping_id": CountrySettings.shared.shipping?.shippingId ?? "7",
                "products": products,
                "coupon_code": code,
                "code_type": couponType,
                "notes":notes
                ] as [String : Any]

            if isOneClickBuy {
                params["order_type"] = "oneclick"
            }
            
            if userData != nil {
                params["user_data"] = userData
            }

            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
            let decoded = String(data: jsonData, encoding: .utf8)!

            print("decoded: \(decoded)")
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)

        case .getAllOrders, .getOrder:
            let customer = Customer.shared
            var userId = "10045"
            if let user = customer.user {
                userId = user.identifier
            }
            return .requestParameters(parameters: [ "user_id": userId
                ], encoding: URLEncoding.queryString)
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

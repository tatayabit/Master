//
//  OrdersEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum OrdersEndpoint {
    case create(products: [String: Any], userId: String, userData: [String: Any]?, paymentId: String, oneClickBuy: Bool, code: String)
    case getAllOrders(page: Int)
    case getOrder(orderId: String)

}


extension OrdersEndpoint: TargetType {
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
        case .create:
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
        case .create(let products, let userId, let userData, let paymentId, let isOneClickBuy, let code):
            var params = [
                "user_id": userId,
                "payment_id": paymentId,
                "shipping_id": CountrySettings.shared.shipping?.shippingId ?? "7",
                "products": products,
                "coupon_code": code
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

        return ["Content-type": "application/json",
                "authorization": "Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }

}

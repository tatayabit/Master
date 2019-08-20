//
//  OrdersEndpoint.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

enum OrdersEndpoint {
    case create(products: [String: Any], userId: String, userData: [String: Any]?)
    case getAllOrders(page: Int)
    case getOrder(orderId: String)
}


extension OrdersEndpoint: TargetType {
    var environmentBaseURL: String {
        switch UserAPIClient.environment {
        case .production: return "http://dev2%40tatayab.com:E970ASsq0e9GmSJ2EX0BLGvskO2UF841@old.tatayab.com/api/"
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
            return "stores/1/orders/"
        case .getAllOrders:
            return "orders/"
        case .getOrder(let orderId):
            return "orders/\(orderId.urlEscaped)"
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
        case .create(let products, let userId, let userData):
            var params = [
                "user_id": userId,
                "payment_id": "2",
                "shipping_id": "9",
                "products": products
                ] as [String : Any]

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

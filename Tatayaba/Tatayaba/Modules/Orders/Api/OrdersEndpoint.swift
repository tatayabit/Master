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
        }
    }

    var method: Moya.Method {
        switch self {
        case .create:
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
        case .create(let products, let userId, let userData):
            var params = [
                "user_id": userId,
                "payment_id": "2",
                "shipping_id": "7",
                "products": products
                ] as [String : Any]

            if userData != nil {
                params["user_data"] = userData
//                    [
//                    "email":"guest@example.com",
//                    "firstname": "Guest",
//                    "lastname": "Guest",
//                    "s_firstname": "Guest",
//                    "s_lastname": "Guest",
//                    "s_country": "US",
//                    "s_city": "Boston",
//                    "s_state": "MA",
//                    "s_zipcode": "02125",
//                    "s_address": "44 Main street",
//                    "b_firstname": "Guest",
//                    "b_lastname": "Guest",
//                    "b_country":"US",
//                    "b_city": "Boston",
//                    "b_state": "MA",
//                    "b_zipcode":"02125",
//                    "b_address": "44 Main street"
//                    ]

            }

            let jsonData = try! JSONSerialization.data(withJSONObject: params, options: [])
            let decoded = String(data: jsonData, encoding: .utf8)!

            print("decoded: \(decoded)")
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
//                {
//                    "user_id": "0",
//                    "payment_id": "2",
//                    "shipping_id": "1",
//                    "products": {
//                        "1": {
//                            "product_id": "12",
//                            "amount": "1"
//                        },
//                        "2": {
//                            "product_id":"13",
//                            "amount":"2"
//                        }
//                    },
//                    "user_data": {
//                        "email":"guest@example.com",
//                        "firstname": "Guest",
//                        "lastname": "Guest",
//                        "s_firstname": "Guest",
//                        "s_lastname": "Guest",
//                        "s_country": "US",
//                        "s_city": "Boston",
//                        "s_state": "MA",
//                        "s_zipcode": "02125",
//                        "s_address": "44 Main street",
//                        "b_firstname": "Guest",
//                        "b_lastname": "Guest",
//                        "b_country":"US",
//                        "b_city": "Boston",
//                        "b_state": "MA",
//                        "b_zipcode":"02125",
//                        "b_address": "44 Main street"
//                    }
//            }
        }
    }

    var headers: [String : String]? {

        return ["Content-type": "application/json",
                "authorization": "Basic ZGUyQHRhdGF5YWIuY29tOkU5NzBBU3NxMGU5R21TSjJFWDBCTEd2c2tPMlVGODQx=="
        ]
    }

}

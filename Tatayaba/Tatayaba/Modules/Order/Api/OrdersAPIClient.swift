//
//  OrdersAPIClient.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct OrdersAPIClient: APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

    static let environment: APIEnvironment = .production

    func CreateOrder(products: [String: Any], userId: String, userData: [String: Any]?, completion: @escaping (APIResult<PlaceOrderResult?, MoyaError>) -> Void) {
        fetch(with: OrdersEndpoint.create(products: products, userId: userId, userData: userData), completion: completion)
    }

    func getAllOrders(page: Int, completion: @escaping (APIResult<OrdersResult?, MoyaError>) -> Void) {
        fetch(with: OrdersEndpoint.getAllOrders(page: 0), completion: completion)
    }
}

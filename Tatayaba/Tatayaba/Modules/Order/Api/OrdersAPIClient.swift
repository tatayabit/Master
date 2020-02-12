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

    static let environment: APIEnvironment = .dev2

    func CreateOrder(products: [String: Any], userId: String, userData: [String: Any]?, paymentId: String, oneClickBuy: Bool,code: String, couponType: String, notes:String, completion: @escaping (APIResult<PlaceOrderResult?, MoyaError>) -> Void) {
        fetch(with: OrdersEndpoint.create(products: products, userId: userId, userData: userData, paymentId: paymentId, oneClickBuy: oneClickBuy, code: code, couponType: couponType, notes: notes), completion: completion)
    }

    func getAllOrders(page: Int, completion: @escaping (APIResult<OrdersResult?, MoyaError>) -> Void) {
        fetch(with: OrdersEndpoint.getAllOrders(page: 0), completion: completion)
    }

    func getOrder(orderId: String, completion: @escaping (APIResult<OrderModel?, MoyaError>) -> Void) {
        fetch(with: OrdersEndpoint.getOrder(orderId: orderId), completion: completion)
    }
    
    func getPaymentUrl(orderId: String, completion: @escaping (APIResult<OrderModel?, MoyaError>) -> Void) {
//        fetch(with: OrdersEndpoint.getPaymentUrl(orderId: orderId), completion: completion)
    }
}

//
//  CartAPIClient.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/8/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct CartAPIClient: APIClient {
    
    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void
    
    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
    
    static let environment: APIEnvironment = .production
    
    func applyCoupon(parameters: [String: Any], completion: @escaping (APIResult<CouponResponse?, MoyaError>) -> Void) {
           fetch(with: CartEndpoint.applyCoupon(parameters: parameters), completion: completion)
       }
    
    func updateServerCart(products: [String: Any], userId: String, paymentId: String, completion: @escaping (APIResult<UpdateServerCartResponse?, MoyaError>) -> Void) {
           fetch(with: CartEndpoint.updateServerCart(products: products, userId: userId, paymentId: paymentId), completion: completion)
       }
    func deleteAllCart(userId: String, completion: @escaping (APIResult<UpdateServerCartResponse?, MoyaError>) -> Void) {
        fetch(with: CartEndpoint.deleteAllCart(userId: userId), completion: completion)
        }
    func getServerCart(userId: String, completion: @escaping (APIResult<CartContentResponse?, MoyaError>) -> Void) {
           fetch(with: CartEndpoint.getServerCart(userId: userId), completion: completion)
           }
    func getTaxAndShipping(countryCode: String, completion: @escaping (APIResult<TaxAndShippingResponse?, MoyaError>) -> Void) {
        fetch(with: CartEndpoint.getTaxAndShipping(countryCode: countryCode), completion: completion)
    }
    
    func getPricesWithUpdatedCurrency(parameters: [String: Any], completion: @escaping (APIResult<ConvertedCurrency?, MoyaError>) -> Void) {
        fetch(with: CartEndpoint.getPricesWithUpdatedCurrency(parameters: parameters), completion: completion)
       }
    func getUpdatedCurrency(parameters: [String: Any], completion: @escaping (APIResult<ConvertedCurrency?, MoyaError>) -> Void) {
     fetch(with: CartEndpoint.getPricesWithUpdatedCurrency(parameters: parameters), completion: completion)
    }
}

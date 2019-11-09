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
    
    func applyCoupon(couponCode: String, completion: @escaping (APIResult<CouponResponse?, MoyaError>) -> Void) {
        fetch(with: CartEndpoint.applyCoupon(code: couponCode), completion: completion)
    }
    
    func getTaxAndShipping(countryCode: String, completion: @escaping (APIResult<TaxAndShippingResponse?, MoyaError>) -> Void) {
        fetch(with: CartEndpoint.getTaxAndShipping(countryCode: countryCode), completion: completion)
    }
}

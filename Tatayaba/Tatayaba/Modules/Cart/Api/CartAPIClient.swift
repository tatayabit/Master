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
    
    func applyCoupon(couponCode: String, completion: @escaping (APIResult<couponResponse?, MoyaError>) -> Void) {
        fetch(with: CartEndpoint.applyCoupon(code: couponCode), completion: completion)
    }
}

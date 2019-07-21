//
//  ShippingAPIClient.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya


struct ShippingAPIClient: APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

    static let environment: APIEnvironment = .production

    func getShippings(completion: @escaping (APIResult<ShippingMethod?, MoyaError>) -> Void) {
        fetch(with: ShippingEndpoint.getShippings, completion: completion)
    }
}

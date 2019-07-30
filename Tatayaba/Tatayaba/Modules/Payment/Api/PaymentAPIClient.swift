//
//  PaymentAPIClient.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya


struct PaymentAPIClient: APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

    static let environment: APIEnvironment = .production

    func getPayments(completion: @escaping (APIResult<PaymentResult?, MoyaError>) -> Void) {
        fetch(with: PaymentEndpoint.getPayments, completion: completion)
    }
}

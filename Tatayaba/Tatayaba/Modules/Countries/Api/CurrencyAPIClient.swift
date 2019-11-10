//
//  CountriesAPIClient.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 11/3/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct CurrencyAPIClient: APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

    static let environment: APIEnvironment = .production

    func getCurrencies(completion: @escaping (APIResult<[Currency]?, MoyaError>) -> Void) {
        fetch(with: CurrencyEndpoint.getCurrencies(), completion: completion)
    }
}

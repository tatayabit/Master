//
//  CountriesAPIClient.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 11/3/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct CountriesAPIClient: APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

    static let environment: APIEnvironment = .dev2

    func getCountries(completion: @escaping (APIResult<[Country]?, MoyaError>) -> Void) {
        fetch(with: CountriesEndpoint.getCountries, completion: completion)
    }
}

//
//  VersionValidationAPIClient.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 11/24/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct VersionValidationAPIClient: APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

    static let environment: APIEnvironment = .dev2

    func getVersionValidation(version: String, completion: @escaping (APIResult<[String: String]?, MoyaError>) -> Void) {
        fetch(with: VersionValidationEndpoint.getVersionValidation(version: version), completion: completion)
    }
}

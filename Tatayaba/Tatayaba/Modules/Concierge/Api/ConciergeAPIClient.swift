//
//  ConciergeAPIClient.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/24/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya


struct ConciergeAPIClient: APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

    static let environment: APIEnvironment = .dev2
    func uploadConcierge(concierge: Concierge, completion: @escaping (APIResult<[String: String]?, MoyaError>) -> Void) {
        fetch(with: ConciergeEndpoint.uploadConcierge(concierge: concierge), completion: completion)
    }

}

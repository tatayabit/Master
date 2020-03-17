//
//  BlocksAPIClient.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/19/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya


struct BlocksAPIClient: APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

    static let environment: APIEnvironment = .dev2
    func getBlock(blockId: String, completion: @escaping (APIResult<Block?, MoyaError>) -> Void) {
        fetch(with: BlocksEndpoint.getBlock(blockId: blockId), completion: completion)
    }

}

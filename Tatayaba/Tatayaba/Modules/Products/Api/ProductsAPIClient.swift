//
//  ProductsAPIClient.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/7/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya


struct ProductsAPIClient: APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

    static let environment: APIEnvironment = .production


    func getProducts(completion: @escaping (APIResult<[Product]?, MoyaError>) -> Void) {
        fetch(with: ProductsEndpoint.getProducts, completion: completion)
    }
}

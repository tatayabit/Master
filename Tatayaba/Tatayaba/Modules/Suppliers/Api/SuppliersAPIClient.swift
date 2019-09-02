//
//  SuppliersAPIClient.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/1/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct SuppliersAPIClient: APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

    static let environment: APIEnvironment = .production

    func getSuppliers(completion: @escaping (APIResult<SuppliersResult?, MoyaError>) -> Void) {
        fetch(with: SuppliersEndpoint.getSuppliers(), completion: completion)
    }

    func getProductsOfSupplier(supplierId: String, completion: @escaping (APIResult<[Product]?, MoyaError>) -> Void) {
        fetch(with: SuppliersEndpoint.getProductsOfSupplier(supplierId: supplierId), completion: completion)
    }
}

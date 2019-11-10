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

    func getSuppliers(page: Int, completion: @escaping (APIResult<SuppliersResult?, MoyaError>) -> Void) {
        fetch(with: SuppliersEndpoint.getSuppliers(page: String(page)), completion: completion)
    }

    func getSupplierDetails(supplierId: String, completion: @escaping (APIResult<Supplier?, MoyaError>) -> Void) {
        fetch(with: SuppliersEndpoint.getSupplierDetails(supplierId: supplierId), completion: completion)
    }
}

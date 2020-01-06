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
    
    func getSuppliersSortedByPosition(page: Int, completion: @escaping (APIResult<SuppliersResult?, MoyaError>) -> Void) {
        fetch(with: SuppliersEndpoint.getSuppliersSortedByPosition(page: String(page)), completion: completion)
    }

    func getSupplierDetails(supplierId: String, page: Int, completion: @escaping (APIResult<Supplier?, MoyaError>) -> Void) {
        fetch(with: SuppliersEndpoint.getSupplierDetails(supplierId: supplierId, page: String(page)), completion: completion)
    }
    func getFilteredProductOfSupplier(supplierId: String, page: String,sort_by:String,sort_order:String, completion: @escaping (APIResult<Supplier?, MoyaError>) -> Void) {
        fetch(with: SuppliersEndpoint.getFilteredProductOfSupplier(supplierId: supplierId, page: String(page), sort_by: sort_by, sort_order: sort_order), completion: completion)
    }
}

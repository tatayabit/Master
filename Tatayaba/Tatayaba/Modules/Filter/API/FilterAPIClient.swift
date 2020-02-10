//
//  FilterAPIClient.swift
//  Tatayaba
//
//  Created by new on 1/14/20.
//  Copyright © 2020 Shaik. All rights reserved.
//
import Moya

struct FilterAPIClient: APIClient {

    typealias JSONTaskCompletionHandler = (Decodable?, APIError?) -> Void

    var provider = MoyaProvider<MultiTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])

    static let environment: APIEnvironment = .dev3

    func getFilteredProduct(parameters: [String: Any], completion: @escaping (APIResult<ProductsResult?, MoyaError>) -> Void) {
        fetch(with: FilterEndpoint.getFilteredProduct(parameters: parameters), completion: completion)
    }
    func getSuppliers( completion: @escaping (APIResult<SuppliersResult?, MoyaError>) -> Void) {
        fetch(with: FilterEndpoint.getSuppliers, completion: completion)
    }
    func getCategories( completion: @escaping (APIResult<CategoriesResult?, MoyaError>) -> Void) {
        fetch(with: FilterEndpoint.getCategories, completion: completion)
    }
    
    
}

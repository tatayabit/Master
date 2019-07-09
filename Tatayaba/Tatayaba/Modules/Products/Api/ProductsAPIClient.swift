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

    func getAllCategories(completion: @escaping (APIResult<CategoriesResult?, MoyaError>) -> Void) {
        fetch(with: ProductsEndpoint.getAllCategories, completion: completion)
    }

    func getProductOf(categoryId: Int, page: Int, completion: @escaping (APIResult<ProductsResult?, MoyaError>) -> Void) {
        fetch(with: ProductsEndpoint.getProductsOfCategory(categoryId: String(categoryId), page: String(page)), completion: completion)
    }

    func getProductFeatures(completion: @escaping (APIResult<[Product]?, MoyaError>) -> Void) {
        fetch(with: ProductsEndpoint.getProductFeatures, completion: completion)
    }

}

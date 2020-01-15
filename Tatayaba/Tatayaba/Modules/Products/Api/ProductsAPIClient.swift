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
    
    static let environment: APIEnvironment = .dev3


    func getProducts(completion: @escaping (APIResult<ProductsResult?, MoyaError>) -> Void) {
        fetch(with: ProductsEndpoint.getProducts, completion: completion)
    }

    func getAllCategories(completion: @escaping (APIResult<CategoriesResult?, MoyaError>) -> Void) {
        fetch(with: ProductsEndpoint.getAllCategories, completion: completion)
    }

    func getProductOf(categoryId: Int, page: Int, completion: @escaping (APIResult<ProductsResult?, MoyaError>) -> Void) {
        fetch(with: ProductsEndpoint.getProductsOfCategory(categoryId: String(categoryId), page: String(page)), completion: completion)
    }

    func getProductFeatures(completion: @escaping (APIResult<ProductsResult?, MoyaError>) -> Void) {
        fetch(with: ProductsEndpoint.getProductFeatures, completion: completion)
    }
    
    func getProductDetails(productId: String, completion: @escaping (APIResult<Product?, MoyaError>) -> Void) {
        fetch(with: ProductsEndpoint.getProductDetails(productId: productId), completion: completion)
    }

    func getAlsoBoughtProducts(productId: String, completion: @escaping (APIResult<Block?, MoyaError>) -> Void) {
        fetch(with: ProductsEndpoint.getAlsoBoughtProducts(productId: productId), completion: completion)
    }
    
    func search(with keyword: String, page: Int, completion: @escaping (APIResult<ProductsResult?, MoyaError>) -> Void) {
        fetch(with: ProductsEndpoint.search(keyword: keyword, page: String(page)), completion: completion)
    }
    
    func getFilteredProductOfCategory(categoryId: Int, page: Int,sort_by:String,sort_order:String, completion: @escaping (APIResult<ProductsResult?, MoyaError>) -> Void) {
        fetch(with: ProductsEndpoint.getFilteredProductOfCategory(categoryId: String(categoryId), page: String(page), sort_by: sort_by, sort_order: sort_order), completion: completion)
    }
}

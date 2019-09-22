//
//  ProductsListViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

class CatProductsViewModel {
    let apiClient = ProductsAPIClient()

    private var productsList = [Product]()

    var productsCount: Int { return productsList.count }

    var page: Int = 0
    var category: Category

    init(category: Category) {
        self.category = category
    }


    //MARK:- Api
    func getProductsOfCategory(completion: @escaping (APIResult<ProductsResult?, MoyaError>) -> Void) {
        let categoryId = Int(category.identifier) ?? 0
        apiClient.getProductOf(categoryId: categoryId, page: page) { result in
            switch result {
            case .success(let response):
                guard let productResult = response else { return }
                guard let products = productResult.products else { return }

                self.productsList = products
                print(productResult)

            case .failure(let error):
                print("the error \(error)")
            }
            completion(result)
        }
    }

    //MARK:- Product data
    func product(at indexPath: IndexPath) -> Product {
        guard productsList.count > 0 else { return Product() }
        return productsList[indexPath.row]
    }

    //MARK:- ProductDetails ViewModel
    func productDetailsViewModel(at indexPath: IndexPath) -> ProductDetailsViewModel {
        let productViewModel = ProductDetailsViewModel(product: product(at: indexPath))
        return productViewModel
    }

    // MARK:- AddToCart
    func addToCart(at indexPath: IndexPath)  {
        let cart = Cart.shared
        cart.addProduct(product: product(at: indexPath))
    }
}

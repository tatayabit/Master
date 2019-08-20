//
//  ProductsListViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

class ProductsListViewModel {
    let apiClient = ProductsAPIClient()

    private var productsList = [Product]()

    /// This closure is being called once the categories api fetch
    var onProductsListLoad: (() -> ())?

    var productsCount: Int { return productsList.count }

    var categoryId: Int
    var page: Int = 0

    init(categoryId: Int) {
        self.categoryId = categoryId
    }


    //MARK:- Api
    func getProductsOfCategory() {
        apiClient.getProductOf(categoryId: categoryId, page: page) { result in
            switch result {
            case .success(let response):
                guard let productResult = response else { return }
//                guard let products = productResult.products else { return }

                self.productsList = productResult
                print(productResult)

                if let newCategoriesArrived = self.onProductsListLoad {
                    newCategoriesArrived()
                }

            case .failure(let error):
                print("the error \(error)")
            }
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
}

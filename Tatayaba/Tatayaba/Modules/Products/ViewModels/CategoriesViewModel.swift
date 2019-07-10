//
//  BrandViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct CategoriesViewModel {
    let apiClient = ProductsAPIClient()

    //MARK:- Api

    func getAllCategories() {
        apiClient.getAllCategories { result in
            switch result {
            case .success(let response):
                print(response!)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

    func getProductsOfCategory(categoryId: Int, page: Int) {
        apiClient.getProductOf(categoryId: 52, page: 0) { result in
            switch result {
            case .success(let response):
                guard let productResult = response else { return }
                guard let products = productResult.products else { return }

                print(products)

            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
}

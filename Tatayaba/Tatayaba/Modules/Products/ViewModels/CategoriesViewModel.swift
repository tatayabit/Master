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
}

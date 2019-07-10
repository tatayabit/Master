//
//  HomeViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/8/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

class HomeViewModel {

    private let productsApiClient = ProductsAPIClient()

    private var categoriesList = [Category]()
   

    /// This closure is being called once the categories api fetch
    var onCategoriesListLoad: (() -> ())?

    //MARK:- Init
    init() {
        getAllCategories()
    }

    //MARK:- Api

    func getAllCategories() {
        productsApiClient.getAllCategories { result in
            switch result {
            case .success(let response):
                guard let categoriesResult = response else { return }
                guard let categories = categoriesResult.categories else { return }

                self.categoriesList = categories.filter({ $0.parentId == "0" })
                print(categories)


                if let newCategoriesArrived = self.onCategoriesListLoad {
                    newCategoriesArrived()
                }
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
}

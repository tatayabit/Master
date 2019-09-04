//
//  BrandViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

class CategoriesViewModel {
    let apiClient = ProductsAPIClient()

    private var categoriesList = [Category]()

    /// This closure is being called once the categories api fetch
    var onCategoriesListLoad: (() -> ())?

    var categoriesCount: Int { return categoriesList.count }

    //MARK:- Api
    func getAllCategories() {
        apiClient.getAllCategories { result in
            switch result {
            case .success(let response):
                guard let categoriesResult = response else { return }
                guard let categories = categoriesResult.categories else { return }

                self.categoriesList = categories.filter({ $0.parentId == "0" })
                print(self.categoriesList)


                if let newCategoriesArrived = self.onCategoriesListLoad {
                    newCategoriesArrived()
                }
                print(response!)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

    //MARK:- Categories data
    func category(at indexPath: IndexPath) -> Category {
        guard categoriesList.count > 0 else { return Category(identifier: "0") }
        return categoriesList[indexPath.row]
    }


    //MARK:- ProductsListViewModel
    func productsListViewModel(indexPath: IndexPath) -> ProductsListViewModel {
        let category = categoriesList[indexPath.row]
        return ProductsListViewModel(categoryId: Int(category.identifier) ?? 0)
    }
}

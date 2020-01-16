//
//  CategoriesFilterViewModel.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 1/16/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//

import Foundation

protocol CategoriesFilterViewModelInterface {
    func notifyViewLoaded()
    func didSelectRow(at indexPath: IndexPath)
    func categoryCellData(at row: Int) -> (Category, Bool)
    func applyFilterActionPressed()
}


class CategoriesFilterViewModel {
   
    weak var view: CategoriesFilterViewInterface?

    private let apiClient = FilterAPIClient()
    private var allCategories = [Category]()
    private var selectedCategories: [Category]
    
    
    init(selectedCategories: [Category]) {
        self.selectedCategories = selectedCategories
    }
    
    func callFilterCategoriesApi() {
        apiClient.getCategories { result in
            switch result {
            // 3
            case .failure(let error):
                print("Failed: \(error.localizedDescription)")
            // 4
            case .success(let response):
                print("success")
                if let response = response {
                    self.allCategories = response.categories!
                    self.view?.reloadListData()
                }
            }
        }
    }
    
    func categorySelected(at row: Int) -> Bool {
        return selectedCategories.contains(where: {
            $0.identifier == selectedCategories[row].identifier
        })
    }
    
    func addOrRemoveSupplierSelection(at row: Int) {
        let category = allCategories[row]
        if self.selectedCategories.contains(where: {$0.identifier == category.identifier}) {
            self.selectedCategories.removeAll(where: {$0.identifier == category.identifier})
        } else {
            self.selectedCategories.append(category)
        }
    }
}


extension CategoriesFilterViewModel: CategoriesFilterViewModelInterface {
    func categoryCellData(at row: Int) -> (Category, Bool) {
        return (allCategories[row], self.categorySelected(at: row))
    }
    
    func notifyViewLoaded() {
        self.callFilterCategoriesApi()
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        self.addOrRemoveSupplierSelection(at: indexPath.row)
        self.view?.reloadListData()
    }
    
    func applyFilterActionPressed() {
        self.view?.applySelectedCategories(categories: self.selectedCategories)
    }
}

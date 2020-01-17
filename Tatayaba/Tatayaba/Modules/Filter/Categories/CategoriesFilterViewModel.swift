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
    func didSelectSection(at section: Int)
    func subCategoryCellData(at indexPath: IndexPath) -> (Category, Bool)
    func categorySectionData(at section: Int) -> (Category, Bool)
    func applyFilterActionPressed()
}


class CategoriesFilterViewModel {
   
    weak var view: CategoriesFilterViewInterface?

    private let apiClient = FilterAPIClient()
    var allCategories = [Category]()
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
    
    // MARK:- Category
    func categorySelected(at section: Int) -> Bool {
        return selectedCategories.contains(where: {
            $0.identifier == allCategories[section].identifier
        })
    }
    
    func addOrRemoveCategorySectionSelection(at section: Int) {
        let category = allCategories[section]
        if self.selectedCategories.contains(where: {$0.identifier == category.identifier}) {
            self.selectedCategories.removeAll(where: {$0.identifier == category.identifier})
        } else {
            self.removeSubCategoriesIfSelected(at: section)
            self.selectedCategories.append(category)
        }
    }
    
    func removeSubCategoriesIfSelected(at section: Int) {
        let subcategories = allCategories[section].subCategories
        for subCategory in subcategories {
            self.selectedCategories.removeAll(where: {$0.identifier == subCategory.identifier})
        }
    }
    
    // MARK:- SubCategory
    func subCategorySelected(at indexPath: IndexPath) -> Bool {
        return selectedCategories.contains(where: {
            $0.identifier == allCategories[indexPath.section].subCategories[indexPath.row].identifier
        })
    }
    
    func addOrRemoveCategoryRowSelection(at indexPath: IndexPath) {
        let subCategory = allCategories[indexPath.section].subCategories[indexPath.row]
        if self.selectedCategories.contains(where: {$0.identifier == subCategory.identifier}) {
            self.selectedCategories.removeAll(where: {$0.identifier == subCategory.identifier})
        } else {
            if self.categorySelected(at: indexPath.section) {
                let category = allCategories[indexPath.section]
                self.selectedCategories.removeAll(where: {$0.identifier == category.identifier})
            }
            self.selectedCategories.append(subCategory)
        }
    }
}


extension CategoriesFilterViewModel: CategoriesFilterViewModelInterface {
    // Section
    func categorySectionData(at row: Int) -> (Category, Bool) {
        return (allCategories[row], self.categorySelected(at: row))
    }
    
    func didSelectSection(at section: Int) {
        self.addOrRemoveCategorySectionSelection(at: section)
        self.view?.reloadListData()
    }
    
    // Row
    func subCategoryCellData(at indexPath: IndexPath) -> (Category, Bool) {
        return (allCategories[indexPath.section].subCategories[indexPath.row], self.subCategorySelected(at: indexPath))
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        self.addOrRemoveCategoryRowSelection(at: indexPath)
        self.view?.reloadListData()
    }
    
    func notifyViewLoaded() {
        self.callFilterCategoriesApi()
    }
    
    func applyFilterActionPressed() {
        self.view?.applySelectedCategories(categories: self.selectedCategories)
    }
}

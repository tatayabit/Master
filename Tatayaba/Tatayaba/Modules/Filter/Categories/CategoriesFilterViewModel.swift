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
    
    func categorySelected(at section: Int) -> Bool {
        return selectedCategories.contains(where: {
            $0.identifier == allCategories[section].identifier
        })
    }
    
    func subCategorySelected(at indexPath: IndexPath) -> Bool {
        return selectedCategories.contains(where: {
            $0.identifier == allCategories[indexPath.section].subCategories[indexPath.row].identifier
        })
    }
    
    func addOrRemoveCategorySectionSelection(at section: Int) {
        let category = allCategories[section]
        if self.selectedCategories.contains(where: {$0.identifier == category.identifier}) {
            self.selectedCategories.removeAll(where: {$0.identifier == category.identifier})
        } else {
            self.selectedCategories.append(category)
        }
    }
    
    func addOrRemoveCategoryRowSelection(at indexPath: IndexPath) {
        let category = allCategories[indexPath.section].subCategories[indexPath.row]
        if self.selectedCategories.contains(where: {$0.identifier == category.identifier}) {
            self.selectedCategories.removeAll(where: {$0.identifier == category.identifier})
        } else {
            self.selectedCategories.append(category)
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

//
//  FilterRootViewModel.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 1/14/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//

import Foundation
protocol FilterRootViewModelInterface {
    // from view
    func notifyViewLoaded()
    func getCellData(at indexPath: IndexPath) -> (String, String)
    func didSelectRow(at indexPath: IndexPath)
    func rowsCount() -> Int
    func didPressResetFilter()
    
    // from other viewModels
    func didUpdateCategories(newCategories: [Category])
    func didUpdateSuppliers(newSuppliers: [Supplier])
    func didUpdatePrice(newMinimumPrice: Double, newMaximumPrice: Double)
}



class FilterRootViewModel {
    
    weak var view: FilterTableViewInterface?

    private var suppliers = [Supplier]()
    private var categories = [Category]()
    var minimumPrice = 0.00
    var maximumPrice = 10000.0
    private var freeDelivery = false
    private var featured = false
    var initializer: InitializerType
    
    init(initializer: InitializerType) {
        self.initializer = initializer
    }
        
    
    func suppliersData() -> (String, String) {
        return ("Suppliers", self.suppliers.map{ $0.name }.joined(separator: ", "))
    }
    
    func categoriesData() -> (String, String) {
        return ("Categories", self.categories.map{ $0.name }.joined(separator: ", "))
    }
    
    func priceData() -> (String, String) {
        if self.maximumPrice < 10000.00 && self.minimumPrice > 0.00 {
            return ("Price", "\(self.minimumPrice) - \(self.maximumPrice)")
        }
        return ("Price", "")
    }
    
    func freeDeliveryData() -> (String, String) {
        let freeDeliveryString = self.freeDelivery ? "Free Delivery" : ""
        return ("Free Delivery", freeDeliveryString)
    }
    
    func featuredData() -> (String, String) {
        let featuredString = self.featured ? "Featured" : ""
        return ("Featured", featuredString)
    }
    
    func isFilterApplied() -> Bool {
        let suppliersApplied = self.suppliers.count > 0
        let categoriesApplied = self.categories.count > 0
        let minimumApplied = self.minimumPrice > 0.00
        let maxmumApplied = self.maximumPrice > 0.00
        return suppliersApplied && categoriesApplied
            && minimumApplied && maxmumApplied && self.freeDelivery
    }
    
    
    func categoriesCell(at indexPath: IndexPath) -> (String, String) {
        switch InitializerType.CategoryRowTypes(rawValue: indexPath.row) {
        case .supplier:
            return self.suppliersData()
        case .price:
            return self.priceData()
        case .freeDelivery:
            return self.freeDeliveryData()
        case .featured:
            return self.featuredData()
        case .none:
            return ("", "")
        }
    }
    
    func suppliersCell(at indexPath: IndexPath) -> (String, String) {
        switch InitializerType.SupplierRowTypes(rawValue: indexPath.row) {
        case .category:
            return self.categoriesData()
        case .price:
            return self.priceData()
        case .freeDelivery:
            return self.freeDeliveryData()
        case .featured:
            return self.featuredData()
        case .none:
            return ("", "")
        }
    }

    
    func searchCell(at indexPath: IndexPath) -> (String, String) {
        switch InitializerType.SearchRowTypes(rawValue: indexPath.row) {
        case .category:
            return self.categoriesData()
        case .supplier:
            return self.suppliersData()
        case .price:
            return self.priceData()
        case .freeDelivery:
            return self.freeDeliveryData()
        case .featured:
            return self.featuredData()
        case .none:
            return ("", "")
        }
    }

    // MARK:- Did Select Rows
    func didSelectCategoriesCell(at indexPath: IndexPath) {
        switch InitializerType.CategoryRowTypes(rawValue: indexPath.row) {
        case .supplier:
            self.view?.openSuppliersFilter()
        case .price:
            self.view?.openPriceFilter()
        case .freeDelivery: break
        case .featured: break
//            return self.freeDeliveryData()
        case .none: break
        }
    }
    
    func didSelectSuppliersCell(at indexPath: IndexPath) {
        switch InitializerType.SupplierRowTypes(rawValue: indexPath.row) {
        case .category:
            self.view?.openCategoriesFilter()
        case .price:
            self.view?.openPriceFilter()
        case .freeDelivery: break
        case .featured: break
//            return self.freeDeliveryData()
        case .none: break
        }
    }

    
    func didSelectSearchCell(at indexPath: IndexPath) {
        switch InitializerType.SearchRowTypes(rawValue: indexPath.row) {
        case .category:
            self.view?.openCategoriesFilter()
        case .supplier:
            self.view?.openSuppliersFilter()
        case .price:
            self.view?.openPriceFilter()
        case .freeDelivery: break
         case .featured: break
//            return self.freeDeliveryData()
        case .none: break
        }
    }
    
    // MARK:- SupplierFilterViewModel
    func supplierFilterViewModel() -> SupplierFilterViewModel {
        return SupplierFilterViewModel(selectedSuppliers: self.suppliers)
    }
    
    // MARK:- CategoriesFilterViewModel
    func categoriesFilterViewModel() -> CategoriesFilterViewModel {
        return CategoriesFilterViewModel(selectedCategories: self.categories)
    }
    
    // MARK:- FilterRequestModel
    func createFilterRequestModel() -> FilterRequestModel? {
        var requestModel: FilterRequestModel?
        if self.isFilterApplied() {
            requestModel?.page = "0"
            requestModel?.supplier_ids = self.suppliers.map{ $0.supplierId }
            requestModel?.cat_ids = self.categories.map{ $0.identifier }
            requestModel?.min = "\(self.minimumPrice)"
            requestModel?.max = "\(self.maximumPrice)"
        }
        return requestModel
    }
}

extension FilterRootViewModel: FilterRootViewModelInterface {
    
    func notifyViewLoaded() {
        self.view?.setTableDataSource()
    }
    
    func getCellData(at indexPath: IndexPath) -> (String, String) {

        switch self.initializer {
        case .category:
            return self.categoriesCell(at: indexPath)
        case .supplier:
            return self.suppliersCell(at: indexPath)
        case .search:
            return self.searchCell(at: indexPath)
        }
    }
    
    func rowsCount() -> Int {
        
        switch self.initializer {
        case .category:
            return InitializerType.CategoryRowTypes.allCases.count
        case .supplier:
            return InitializerType.SupplierRowTypes.allCases.count
        case .search:
            return InitializerType.SearchRowTypes.allCases.count
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        switch self.initializer {
        case .category:
            self.didSelectCategoriesCell(at: indexPath)
        case .supplier:
            self.didSelectSuppliersCell(at: indexPath)
        case .search:
            return didSelectSearchCell(at: indexPath)
        }
    }
    
    // from other view Models
    func didUpdateCategories(newCategories: [Category]) {
        for category in newCategories {
            if !self.categories.contains(where: { $0.identifier == category.identifier }) {
                self.categories.append(category)
            }
        }
        self.view?.reloadListData()
    }
    
    func didUpdateSuppliers(newSuppliers: [Supplier]) {
        for supplier in newSuppliers {
            if !self.suppliers.contains(where: { $0.supplierId == supplier.supplierId }) {
                self.suppliers.append(supplier)
            }
        }
        self.view?.reloadListData()
    }
    
    func didUpdatePrice(newMinimumPrice: Double, newMaximumPrice: Double) {
        self.minimumPrice = newMinimumPrice
        self.maximumPrice = newMaximumPrice
        self.view?.reloadListData()
    }
    
    func didPressResetFilter() {
        self.suppliers = [Supplier]()
        self.categories = [Category]()
        self.minimumPrice = 0.00
        self.maximumPrice = 0.00
        self.freeDelivery = false
        self.view?.reloadListData()
    }
}

extension FilterRootViewModel {
    
    enum InitializerType {
        case category
        case supplier
        case search
        
        
        enum CategoryRowTypes: Int, CaseIterable {
            case supplier
            case price
            case freeDelivery
            case featured
        }
        
        enum SupplierRowTypes: Int, CaseIterable {
            case category
            case price
            case freeDelivery
            case featured
        }
        
        enum SearchRowTypes: Int, CaseIterable {
            case category
            case supplier
            case price
            case freeDelivery
            case featured
        }
    }
}


//
//  ProductsListViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

protocol CatProductsViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
//    func onFilteringFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
}

class CatProductsViewModel {
    let apiClient = ProductsAPIClient()

    private var productsList = [Product]()
    private var currentPage = 0
    private var total = 0
    private var isFetchInProgress = false
    private var shouldCallApi: Bool = true

    
    private var filterSettings = FilterSettings()
    
    private weak var delegate: CatProductsViewModelDelegate?
    
    var category: Category

    init(category: Category) {
        self.category = category
    }
    
    func setDelegate(_ delegate: CatProductsViewModelDelegate) {
        self.delegate = delegate
    }
    
    // MARK:- Count
    var totalCount: Int {
        return total
    }
    
    var currentCount: Int {
        return productsList.count
    }

    
    // MARK:- fetch more Api
    
    func getFilteredProductsApi() {
        // 1
        guard !isFetchInProgress else {
            return
        }
        
        // 2
        isFetchInProgress = true
        
        let categoryId = Int(category.identifier) ?? 0
        apiClient.getFilteredProductOfCategory(categoryId: categoryId, page: currentPage, sort_by: filterSettings.filter, sort_order: filterSettings.sorting.rawValue) { result in
            
            switch result {
            // 3
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.localizedDescription)
                }
            // 4
            case .success(let response):
                DispatchQueue.main.async {
                    // 1
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    // 2
                    guard let productResult = response else { return }
                    guard let products = productResult.products else { return }
                    
                    if products.count < 20 {
                        self.shouldCallApi = false
                    }
                    self.total += products.count
                    self.productsList.append(contentsOf: products)
                    
                    // 3
                    if self.currentPage > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: products)
                        if let delegate = self.delegate {
                            delegate.onFetchCompleted(with: indexPathsToReload)
                        }
                    } else {
                        if let delegate = self.delegate {
                            delegate.onFetchCompleted(with: .none)
                        }
                    }
                }
            }
        }
    }
    
    func fetchModerators() {
        // 1
        guard !isFetchInProgress else {
            return
        }
        
        // 2
        isFetchInProgress = true
        
        let categoryId = Int(category.identifier) ?? 0
        apiClient.getProductOf(categoryId: categoryId, page: currentPage) { result in
            switch result {
            // 3
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.localizedDescription)
                }
            // 4
            case .success(let response):
                DispatchQueue.main.async {
                    // 1
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    // 2
                    guard let productResult = response else { return }
                    guard let products = productResult.products else { return }
                    
                    if products.count < 20 {
                        self.shouldCallApi = false
                    }
                    self.total += products.count
                    self.productsList.append(contentsOf: products)
                    
                    // 3
                    if self.currentPage > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: products)
                        if let delegate = self.delegate {
                            delegate.onFetchCompleted(with: indexPathsToReload)
                        }
                    } else {
                        if let delegate = self.delegate {
                            delegate.onFetchCompleted(with: .none)
                        }
                    }
                }
            }
        }
    }
    
    private func calculateIndexPathsToReload(from newProducts: [Product]) -> [IndexPath] {
        let startIndex = productsList.count - newProducts.count
        let endIndex = startIndex + newProducts.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
    // MARK:- LoadMoreViewAction
    func loadMoreViewAction() {
        
    }
    
    // MARK:- filter Products Options
    func filterOptions(products: [Product]) {
        
    }

    // MARK:- Product data
    func product(at indexPath: IndexPath) -> Product {
        guard productsList.count > 0 else { return Product() }
        return productsList[indexPath.row]
    }

    // MARK:- ProductDetails ViewModel
    func productDetailsViewModel(at indexPath: IndexPath) -> ProductDetailsViewModel {
        let productViewModel = ProductDetailsViewModel(product: product(at: indexPath))
        return productViewModel
    }
    
    // MARK:- Filter
    func freeDeliveryPressed() {
        self.filterSettings.freeDelivery = !self.filterSettings.freeDelivery
        self.resetAllProdcuts()
        self.getFilteredProductsApi()
    }
    
    
    
    func filterOptionsChanged(filterValue: String) {
        // TODO: add the inputs will be passed from the view
        // call the changes before calling api
        self.resetAllProdcuts()
        self.getFilteredProductsApi()
    }
    
    func sortByOptionsChanged() {
        // TODO: add the inputs will be passed from the view
        // call the changes before calling api
        self.resetAllProdcuts()
        self.getFilteredProductsApi()
    }
    
    
    // MARK:- Reset Data
    private func resetAllProdcuts() {
        self.productsList.removeAll()
        self.currentPage = 0
        self.total = 0
        self.isFetchInProgress = false
        self.shouldCallApi = true
    }

    // MARK:- AddToCart
    func addToCart(at indexPath: IndexPath)  {
        let cart = Cart.shared
        cart.addProduct(product: product(at: indexPath))
    }
    
    func productInStock(at indexPath: IndexPath) -> Bool {
        return product(at: indexPath).isInStock
    }
    
    func productHasOptions(at indexPath: IndexPath) -> Bool {
        return product(at: indexPath).hasOptions
    }
}

extension Constants {
    struct Products {
        static let noProductsFound = "No Products found!".localized()
    }
}

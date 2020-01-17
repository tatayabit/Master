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
    let filterApiClient = FilterAPIClient()

    private var productsList = [Product]()
    private var currentPage = 0
    private var total = 0
    private var isFetchInProgress = false
    private var shouldCallApi: Bool = true

    var filterRequestObj: FilterRequestModel?
    
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

    // MARK:- NewFilter Api
    private func getFilterProductsJsonString(with filterObj:FilterRequestModel) -> [String: Any] {

        var requestJson = [String: Any]()
        
        var currencyId = Constants.Currency.kuwaitCurrencyId
        if let countryCurrency = CurrencySettings.shared.currentCurrency?.currencyId {
            currencyId = countryCurrency
        }

        requestJson["page"] = filterObj.page.urlEscaped
        requestJson["items_per_page"] = 20
        requestJson["available_country_code"] = CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw"
        requestJson["currency_id"] = currencyId.urlEscaped
        requestJson["lang_code"] = LanguageManager.getLanguage()
        
        
        if let sort_by = filterObj.sort_by{
            requestJson["sort_by"] = sort_by.joined(separator:",").urlEscaped
        }
        
        if let sort_order = filterObj.sort_order{
            requestJson["sort_order"] = sort_order
        }
        
        if let cat_ids = filterObj.cat_ids{
            requestJson["cid"] = cat_ids.joined(separator:",").urlEscaped
        }
        
        if let supplier_ids = filterObj.supplier_ids{
            requestJson["supplier_ids"] = supplier_ids.joined(separator:",").urlEscaped
        }
        
        if let min = filterObj.min, let max = filterObj.max{
            requestJson["min"] = min.urlEscaped
            requestJson["max"] = max.urlEscaped
        }
        
        if let searchString = filterObj.searchText{
            requestJson["search"] = "y"
            requestJson["q"] = searchString
        }
        
        return requestJson
    }
    
    func getFilteredProducts() {
        // 1
       guard !isFetchInProgress else {
           return
       }

       // 2
       isFetchInProgress = true
        
        filterApiClient.getFilteredProduct(parameters: self.getFilterProductsJsonString(with: self.filterRequestObj!)) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    // 1
                    self.currentPage += 1
                    self.filterRequestObj?.page = "\(self.currentPage)"
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
//                if let response = response {
//                    print(result.products?.count as Any)
//                    self.productsList = result.products!
//                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.delegate?.onFetchFailed(with: error.localizedDescription)
                }
                print("the error \(error)")
            }
        }
    }
    
    // MARK:- fetch more Api
    
//    func getFilteredProductsApi() {
//        // 1
//        guard !isFetchInProgress else {
//            return
//        }
//
//        // 2
//        isFetchInProgress = true
//
//        let categoryId = Int(category.identifier) ?? 0
//        apiClient.getFilteredProductOfCategory(categoryId: categoryId, page: currentPage, sort_by: filterSettings.filter, sort_order: filterSettings.sorting.rawValue) { result in
//
//            switch result {
//            // 3
//            case .failure(let error):
//                DispatchQueue.main.async {
//                    self.isFetchInProgress = false
//                    self.delegate?.onFetchFailed(with: error.localizedDescription)
//                }
//            // 4
//            case .success(let response):
//                DispatchQueue.main.async {
//                    // 1
//                    self.currentPage += 1
//                    self.isFetchInProgress = false
//                    // 2
//                    guard let productResult = response else { return }
//                    guard let products = productResult.products else { return }
//
//                    if products.count < 20 {
//                        self.shouldCallApi = false
//                    }
//                    self.total += products.count
//                    self.productsList.append(contentsOf: products)
//
//                    // 3
//                    if self.currentPage > 1 {
//                        let indexPathsToReload = self.calculateIndexPathsToReload(from: products)
//                        if let delegate = self.delegate {
//                            delegate.onFetchCompleted(with: indexPathsToReload)
//                        }
//                    } else {
//                        if let delegate = self.delegate {
//                            delegate.onFetchCompleted(with: .none)
//                        }
//                    }
//                }
//            }
//        }
//    }
    
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
        if self.filterRequestObj == nil {
            self.fetchModerators()
        } else {
            self.getFilteredProducts()
        }
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
    func sortByOptionsChanged(sortBy: FilterSettings.SortingOptions) {
        // TODO: add the inputs will be passed from the view
        // call the changes before calling api
        self.resetAllProdcuts()
//        self.filterSettings.sorting = sortBy
//        self.getFilteredProductsApi()
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
    
    // MARK:- applyFilter
    func didApplyFilter(filterRequestModel: FilterRequestModel?) {
        self.filterRequestObj = filterRequestModel
        self.resetAllProdcuts()
        if filterRequestModel != nil {
            getFilteredProducts()
        } else {
            self.fetchModerators()
        }
    }
    
    // MARK:- Filter ViewModel
    func filterViewModel() -> FilterRootViewModel {
        return FilterRootViewModel(initializer: .category, requestModel: self.filterRequestObj)
    }
}

extension Constants {
    struct Products {
        static let noProductsFound = "No Products found!".localized()
    }
}

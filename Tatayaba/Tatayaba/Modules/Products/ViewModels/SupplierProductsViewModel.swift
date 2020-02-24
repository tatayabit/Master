//
//  SupplierProductsViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

protocol SupplierProductsViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
//    func onFilteringFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
}

class SupplierProductsViewModel {
    let apiClient = SuppliersAPIClient()
    let filterApiClient = FilterAPIClient()

    var supplier: Supplier
    
    
    private var productsList = [Product]()
    private var currentPage = 0
    private var total = 0
    
    private var isFetchInProgress = false
    private var shouldCallApi: Bool = true

    var filterRequestObj: FilterRequestModel?
    
    private weak var delegate: SupplierProductsViewModelDelegate?

    init(supplier: Supplier) {
        self.supplier = supplier
    }
    
    func setDelegate(_ delegate: SupplierProductsViewModelDelegate) {
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
        requestJson["items_per_page"] = 100
        requestJson["available_country_code"] = CountrySettings.shared.currentCountry?.code.lowercased() ?? "kw"
        requestJson["currency_id"] = currencyId.urlEscaped
        requestJson["lang_code"] = LanguageManager.getLanguage()
        
        if (filterObj.sort_by.count > 0 ){
            requestJson["sort_by"] = filterObj.sort_by.joined(separator:",").urlEscaped
        }
        
        if let sort_order = filterObj.sort_order{
            requestJson["sort_order"] = sort_order
        }
        
        
        if let cat_ids = filterObj.cat_ids{
            if (cat_ids.count > 0 ){
            requestJson["cid"] = cat_ids.joined(separator:",").urlEscaped
            }
        }
        
//        if let supplier_ids = filterObj.supplier_ids{
//            if (supplier_ids.count > 0 ){
                requestJson["supplier_ids"] = self.supplier.supplierId.urlEscaped
//            }
//        }
        
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
    //        if !shouldCallApi {
    //            return
    //        }
    //
    //
    //        guard !isFetchInProgress else {
    //            return
    //        }
             
             // 2
    //         isFetchInProgress = true
             filterApiClient.getFilteredProduct(parameters: self.getFilterProductsJsonString(with: self.filterRequestObj!)) { result in

                 switch result {
                 // 3
                 case .failure(let error):
                     DispatchQueue.main.async {
    //                     self.isFetchInProgress = false
                         self.delegate?.onFetchFailed(with: error.localizedDescription)
                     }
                 // 4
                 case .success(let response):
                     DispatchQueue.main.async {
                        // 1
    //                    self.currentPage += 1
    //                    self.isFetchInProgress = false
                        // 2
                        
                        guard let supplierResult = response else { return }
                        
//                        self.supplier = supplierResult
//                        print(self.supplier)
                         
    //                    if supplierResult.products.count < 20 {
    //                        self.shouldCallApi = false
    //                    }
                        
                        self.total += supplierResult.products!.count
                        self.productsList.append(contentsOf: (supplierResult.products!))
                         
                        // 3
    //                    if self.currentPage > 1 {
    //                        let indexPathsToReload = self.calculateIndexPathsToReload(from: supplierResult.products)
    //                        if let delegate = self.delegate {
    //                            delegate.onFetchCompleted(with: indexPathsToReload)
    //                        }
    //                    } else {
                            if let delegate = self.delegate {
                                delegate.onFetchCompleted(with: .none)
                            }
    //                    }
                     }
                 }
             }
         }

//    //MARK:- Api
//    func getSupplierDetails(completion: @escaping (APIResult<Supplier?, MoyaError>) -> Void) {
//
//        apiClient.getSupplierDetails(supplierId: supplier.supplierId, page: currentPage) { result in
//            switch result {
//            case .success(let response):
//                guard let supplierResult = response else { return }
//                //                guard let products = supplier.products else { return }
//
//                self.supplier = supplierResult
//                print(self.supplier)
//
//            case .failure(let error):
//                print("the error \(error)")
//            }
//            completion(result)
//        }
//    }
    
    
//    func getFilteredProductsApi() {
//        apiClient.getFilteredProductOfSupplier(supplierId: supplier.supplierId, page: currentPage, sort_by: filterSettings.filter, sort_order:filterSettings.sorting.rawValue) { result in
//
//            switch result {
//            // 3
//            case .failure(let error):
//                 DispatchQueue.main.async {
//                     self.delegate?.onFetchFailed(with: error.localizedDescription)
//                 }
//             // 4
//            case .success(let response):
//                DispatchQueue.main.async {
//                    guard let supplierResult = response else { return }
//
////                    self.supplier = supplierResult
//                    print(self.supplier)
//
//                    self.total += supplierResult.products.count
//                    self.productsList.append(contentsOf: supplierResult.products)
//
//                    if let delegate = self.delegate {
//                        delegate.onFetchCompleted(with: .none)
//                    }
//                }
//            }
//        }
//    }
    
    // MARK:- fetch more Api
     func fetchModerators() {
         // 1
        if !shouldCallApi {
            return
        }


        guard !isFetchInProgress else {
            return
        }
         
//          2
         isFetchInProgress = true
         
         apiClient.getSupplierDetails(supplierId: supplier.supplierId, page: currentPage) { result in
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
                    guard let supplierResult = response else { return }
                    
                    self.supplier = supplierResult
                    print(self.supplier)
                     
                    if supplierResult.products.count < 20 {
                        self.shouldCallApi = false
                    }
                    
                    self.total += supplierResult.products.count
                    self.productsList.append(contentsOf: (supplierResult.products))
                     
                    // 3
//                    if self.currentPage > 1 {
//                        let indexPathsToReload = self.calculateIndexPathsToReload(from: supplierResult.products)
//                        if let delegate = self.delegate {
//                            delegate.onFetchCompleted(with: indexPathsToReload)
//                        }
//                    } else {
                        if let delegate = self.delegate {
                            delegate.onFetchCompleted(with: .none)
                        }
//                    }
                 }
             }
         }
     }
     
     private func calculateIndexPathsToReload(from newProducts: [Product]) -> [IndexPath] {
         let startIndex = productsList.count - newProducts.count
         let endIndex = startIndex + newProducts.count
         return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
     }
     

    //MARK:- Product data
    func product(at indexPath: IndexPath) -> Product {
        guard productsList.count > 0 else { return Product() }
        return productsList[indexPath.row]
    }

    //MARK:- ProductDetails ViewModel
    func productDetailsViewModel(at indexPath: IndexPath) -> ProductDetailsViewModel {
        let productViewModel = ProductDetailsViewModel(product: product(at: indexPath))
        return productViewModel
    }
    
    // MARK:- Filter
    func sortByOptionsChanged(sortBy: FilterSettings.SortingOptions) {
        // call the changes before calling api
        self.resetAllProdcuts()
//        self.filterSettings.sorting = sortBy
//        self.getFilteredProductsApi()
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
        return FilterRootViewModel(initializer: .supplier, requestModel: self.filterRequestObj)
    }
    
    // MARK:- Reset Data
    private func resetAllProdcuts() {
        self.productsList.removeAll()
        self.currentPage = 0
        self.total = 0
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

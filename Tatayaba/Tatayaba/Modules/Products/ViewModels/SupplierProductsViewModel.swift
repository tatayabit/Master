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
}

class SupplierProductsViewModel {
    let apiClient = SuppliersAPIClient()

    var supplier: Supplier
    
    
    private var productsList = [Product]()
    private var currentPage = 0
    private var total = 0
    private var isFetchInProgress = false
    private var shouldCallApi: Bool = true

    
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
    
    // MARK:- fetch more Api
     func fetchModerators() {
         // 1
        if !shouldCallApi {
            return
        }
        
        
        guard !isFetchInProgress else {
            return
        }
         
         // 2
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
                    self.productsList.append(contentsOf: supplierResult.products)
                     
                    // 3
                    if self.currentPage > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: supplierResult.products)
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

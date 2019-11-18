//
//  SuppliersListViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/7/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

protocol SuppliersListViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

class SuppliersListViewModel {
    let apiClient = SuppliersAPIClient()
    var suppliersList = [Supplier]()
    
    private var currentPage = 0
    private var total = 0
    private var isFetchInProgress = false
    
    
    private weak var delegate: SuppliersListViewModelDelegate?
    

    /// This closure is being called once the categories api fetch
//    var onsuppliersListLoad: (() -> ())?
    
    // MARK:- Count
      var totalCount: Int {
          return total
      }
      
      var currentCount: Int {
          return suppliersList.count
      }
    
    var shouldCallApi: Bool = true
    

    //MARK:- Api
//    func getSuppliersList() {
//        apiClient.getSuppliers { result in
//            switch result {
//            case .success(let response):
//                guard let suppliersResult = response else { return }
////                                self.squareBlock = block
//                guard let suppliers = suppliersResult.suppliers else { return }
//
//                self.suppliersList = suppliers
////                print(suppliersList)
////                if let newSuppliersArrived = self.onsuppliersListLoad {
////                    newSuppliersArrived()
////                }
//
//            case .failure(let error):
//                print("the error \(error)")
//            }
//        }
//    }
    
    func setDelegate(_ delegate: SuppliersListViewModelDelegate) {
        self.delegate = delegate
    }
    
    func reset() {
        self.currentPage = 0
        self.total = 0
        self.suppliersList.removeAll()
        fetchModerators()
        self.shouldCallApi = true
    }
    
    // MARK:- fetch more Api
    func fetchModerators() {
//        if !shouldCallApi {
//            return
//        }
        
        // 1
        guard !isFetchInProgress else {
            return
        }
        
        // 2
        isFetchInProgress = true
        
        apiClient.getSuppliers(page: currentPage) { result in
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
                    guard let suppliersResult = response else { return }
                    guard let suppliers = suppliersResult.suppliers else { return }
                    
                    
//                    if suppliers.count < 20 {
//                        self.shouldCallApi = false
//                    }
                    
                    self.total += suppliers.count
                    self.suppliersList.append(contentsOf: suppliers)
                    
                    // 3
                    if self.currentPage > 1 {
                        let indexPathsToReload = self.calculateIndexPathsToReload(from: suppliers)
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
    
    private func calculateIndexPathsToReload(from newSuppliers: [Supplier]) -> [IndexPath] {
        let startIndex = suppliersList.count - newSuppliers.count
        let endIndex = startIndex + newSuppliers.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }


    //MARK:- Supplier data
    func supplier(at indexPath: IndexPath) -> Supplier {
        guard suppliersList.count > 0 else { return Supplier() }
        return suppliersList[indexPath.row]
    }

    //MARK:- SupplierProductsViewModel
    func supplierProductsViewModel(indexPath: IndexPath) -> SupplierProductsViewModel {
        let supplier = suppliersList[indexPath.row]
        return SupplierProductsViewModel(supplier: supplier)
    }
    
    
}

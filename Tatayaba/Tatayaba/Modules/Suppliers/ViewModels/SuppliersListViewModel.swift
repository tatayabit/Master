//
//  SuppliersListViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/7/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

class SuppliersListViewModel {
    let apiClient = SuppliersAPIClient()

    var suppliersList = [Supplier]()

    /// This closure is being called once the categories api fetch
    var onsuppliersListLoad: (() -> ())?

    //MARK:- Api
    func getSuppliersList() {
        apiClient.getSuppliers { result in
            switch result {
            case .success(let response):
                guard let suppliersResult = response else { return }
                //                self.squareBlock = block
                let suppliers = suppliersResult

                self.suppliersList = suppliers
//                print(suppliersList)
                if let newSuppliersArrived = self.onsuppliersListLoad {
                    newSuppliersArrived()
                }

            case .failure(let error):
                print("the error \(error)")
            }
        }
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

    //MARK:- ProductDetails ViewModel
//    func productDetailsViewModel(at indexPath: IndexPath) -> ProductDetailsViewModel {
//        let productViewModel = ProductDetailsViewModel(product: product(at: indexPath))
//        return productViewModel
//    }
}

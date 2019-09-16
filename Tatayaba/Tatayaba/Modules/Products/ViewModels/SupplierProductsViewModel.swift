//
//  SupplierProductsViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

class SupplierProductsViewModel {
    let apiClient = SuppliersAPIClient()


    /// This closure is being called once the categories api fetch
    var onSupplierLoad: (() -> ())?

//    var productsCount: Int { return productsList.count }

    var page: Int = 0
    var supplier: Supplier

    init(supplier: Supplier) {
        self.supplier = supplier
    }


    //MARK:- Api
    func getSupplierDetails() {
        apiClient.getSupplierDetails(supplierId: supplier.supplierId) { result in
            switch result {
            case .success(let response):
                guard let supplierResult = response else { return }
//                guard let products = supplier.products else { return }

                self.supplier = supplierResult
                print(self.supplier)

                if let newSuppilerArrived = self.onSupplierLoad {
                    newSuppilerArrived()
                }

            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

    //MARK:- Product data
    func product(at indexPath: IndexPath) -> Product {
        guard supplier.products.count > 0 else { return Product() }
        return supplier.products[indexPath.row]
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
}

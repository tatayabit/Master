//
//  SupplierFilterViewModel.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 1/13/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//

protocol SupplierFilterViewModelInterface {
    func notifyViewLoaded()
    func search(with text: String)
//    func supplier(at row: Int) -> Supplier
}

class SupplierFilterViewModel: SupplierFilterViewModelInterface {
    weak var view: SupplierFilterViewInterface?

    private var allSuppliers = [Supplier]()

    func notifyViewLoaded() {}
    func search(with text: String) {}
//    func supplier(at row: Int) -> Supplier {}
    
    
}

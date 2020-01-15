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

class SupplierFilterViewModel {
    weak var view: SupplierFilterViewInterface?

    private var allSuppliers = [Supplier]()
    var resultSuppliers: [Supplier]
    
    init() {
        self.resultSuppliers = allSuppliers
    }
    
}

extension SupplierFilterViewModel: SupplierFilterViewModelInterface {
    func notifyViewLoaded() {
        self.view?.reloadListData()
    }
    
    func search(with text: String) {
        self.resultSuppliers = self.allSuppliers.filter{ $0.name.contains(text) }
        self.view?.reloadListData()
    }
    
    //    func supplier(at row: Int) -> Supplier {}
}

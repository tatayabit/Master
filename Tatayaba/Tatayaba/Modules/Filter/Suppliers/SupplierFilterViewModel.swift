//
//  SupplierFilterViewModel.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 1/13/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//
import Foundation

protocol SupplierFilterViewModelInterface {
    func notifyViewLoaded()
    func search(with text: String)
    func didSelectRow(at indexPath: IndexPath)
    func supplierCellData(at row: Int) -> (Supplier, Bool)
    func applyFilterActionPressed()
}

class SupplierFilterViewModel {
    weak var view: SupplierFilterViewInterface?
    
    private let apiClient = FilterAPIClient()
    private var allSuppliers = [Supplier]()
    var resultSuppliers: [Supplier]
    private var selectedSuppliers: [Supplier]
    
    init(selectedSuppliers: [Supplier]) {
        self.resultSuppliers = allSuppliers
        self.selectedSuppliers = selectedSuppliers
    }
    
    func callFilterSuppliersApi() {
        var obj = BaseViewController()
        apiClient.getSuppliers() { result in
            switch result {
            // 3
            case .failure(let error):
                
                print("Failed: \(error.localizedDescription)")
            // 4
            case .success(let response):
                print("success")
                if let response = response {
                    self.allSuppliers = response.suppliers!
                    self.resultSuppliers = self.allSuppliers
                    self.view?.reloadListData()
                }
            }
        }
    }
    
    func supplierSelected(at row: Int) -> Bool {
        return selectedSuppliers.contains(where: {
            $0.supplierId == resultSuppliers[row].supplierId
        })
    }
    
    func addOrRemoveSupplierSelection(at row: Int) {
        let supplier = resultSuppliers[row]
        if self.selectedSuppliers.contains(where: {$0.supplierId == supplier.supplierId}) {
            self.selectedSuppliers.removeAll(where: {$0.supplierId == supplier.supplierId})
        } else {
            self.selectedSuppliers.append(supplier)
        }
    }
}

extension SupplierFilterViewModel: SupplierFilterViewModelInterface {
    func notifyViewLoaded() {
        self.callFilterSuppliersApi()
//        self.view?.reloadListData()
    }
    
    func search(with text: String) {
        if text.count > 0 {
            self.resultSuppliers = self.allSuppliers.filter{ $0.name.lowercased().contains(text.lowercased()) }
        } else {
            self.resultSuppliers = self.allSuppliers
        }
        self.view?.reloadListData()
    }
    
    func supplierCellData(at row: Int) -> (Supplier, Bool) {
        return (resultSuppliers[row], self.supplierSelected(at: row))
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        self.addOrRemoveSupplierSelection(at: indexPath.row)
        self.view?.reloadListData()
    }
    
    func applyFilterActionPressed() {
        self.view?.applySelectedSuppliers(suppliers: self.selectedSuppliers)
    }
}

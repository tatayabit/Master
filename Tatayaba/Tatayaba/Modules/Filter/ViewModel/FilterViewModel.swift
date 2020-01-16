//
//  FilterViewModel.swift
//  Tatayaba
//
//  Created by new on 1/14/20.
//  Copyright © 2020 Shaik. All rights reserved.
//

import Foundation

class FilterViewModel {
    
    let apiClient = FilterAPIClient()
    let suppliersApiClient = SuppliersAPIClient()
    var currentPage:Int = 0
    private var isFetchInProgress = false
    private var shouldCallApi: Bool = true
    private var productsList = [Product]()
    var suppliersList = [Supplier]()
    private var categoriesList = [Category]()
    
    
    func getFilteredProducts(with filterObj:FilterRequestModel) {
        apiClient.getFilteredProduct(parameters: self.getFilterProductsJsonString(with: filterObj)) { result in
            switch result {
            case .success(let result):
                if let result = result {
                    print(result.products?.count as Any)
                    self.productsList = result.products!
                }
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    
    func getSupplierList() {
        
            apiClient.getSuppliers() { result in
            switch result {
            // 3
            case .failure(let error):
                print("Failed")
            // 4
            case .success(let response):
                print("Sucess")
                if let response = response {
                    self.suppliersList = response.suppliers!
                }
            }
        }
    }
        
    func getCategoriesList() {
        
            apiClient.getCategories() { result in
            switch result {
            // 3
            case .failure(let error):
                print("Failed")
            // 4
            case .success(let response):
                print("Sucess")
                if let response = response {
                    self.categoriesList = response.categories!
                }
            }
        }
        
    }
    func checkNewSuppliers(newSuppliers:[Supplier]) -> Bool {
        for supplier in suppliersList {
            if (newSuppliers[0].supplierId == supplier.supplierId ) {
                self.shouldCallApi = false
                return false
            }
        }
        return true
    }
    
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
        
        return requestJson
    }

}

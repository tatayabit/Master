//
//  ProductDetailsViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/10/19.
//  Copyright © 2019 Shaik. All rights reserved.
//
import Moya

struct OptionsSelection {
    var section: Int
    var selectedVariant: String
}

class ProductDetailsViewModel {
    
    let apiClient = ProductsAPIClient()

    private var product: Product
    private var recommendedList = [Product]()

    var optionsCount: Int { return self.product.productOptions.count }
    private var selectedOptions = [OptionsSelection]()
    
    
    //MARK:- Init
    init(product: Product) {
        self.product = product
    }
    
    //MARK:- Api
    func getProductDetails(completion: @escaping (APIResult<Product?, MoyaError>) -> Void) {
        
        apiClient.getProductDetails(productId: product.identifier) { result in
            switch result {
                
            case .success(let response):
                guard let productResult = response else { return }
                self.product = productResult
                print(self.product)
                
            case .failure(let error):
                print("the error \(error)")
            }
            completion(result)
        }
    }

    //MARK:- Product Details
    func addToCart()  {
        let cart = Cart.shared
        cart.addProduct(product: product)
    }

    //MARK:- Product Options Header
    func optionHeader(at section: Int) -> ProductOption {
        return self.product.productOptions[section - 1]
    }
    
    //MARK:- Product Options variants
    func numberOfVariants(at section: Int) -> Int {
        // first row always not options section
        if section == 0 { return 0 }
        return self.product.productOptions[section - 1].variants.count
    }
    
    func optionVariant(at indexPath: IndexPath) -> ProductVariant {
        return self.product.productOptions[indexPath.section - 1].variants[indexPath.row]
    }
    
    
    // MARK:- select / unselect options handler
    func didSelectOption(at indexPath: IndexPath) {
        if selected(at: indexPath) {
            self.unselectOption(at: indexPath)
        } else {
            self.selectOption(at: indexPath)
        }
    }
    
    // MARK:- Options Selections
    func selected(at indexPath: IndexPath) -> Bool {
        let variant = optionVariant(at: indexPath)
        let foundOptions = self.selectedOptions.filter{ $0.section == indexPath.section && $0.selectedVariant == variant.identifier }
        return foundOptions.count > 0
    }
    
    func selectOption(at indexPath: IndexPath) {
        let variant = optionVariant(at: indexPath)
        let option = OptionsSelection(section: indexPath.section, selectedVariant: variant.identifier)
        self.selectedOptions.append(option)
    }
    
    func unselectOption(at indexPath: IndexPath) {
        let variant = optionVariant(at: indexPath)
        let foundOptions = self.selectedOptions.filter{ $0.section == indexPath.section && $0.selectedVariant == variant.identifier }
        if foundOptions.count > 0 {
            self.selectedOptions.removeAll(where: { $0.section == indexPath.section && $0.selectedVariant == variant.identifier })
        }
    }
    
    // MARK:- ProductDeatailsTableViewCellViewModel
    func detailsCellVM() -> ProductDeatailsTableViewCellViewModel {
        return ProductDeatailsTableViewCellViewModel(product: self.product)
    }
}

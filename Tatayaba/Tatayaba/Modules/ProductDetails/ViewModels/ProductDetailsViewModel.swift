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
    
    // Selection part
    private var selectedOptions = [OptionsSelection]()
    private var selectedQuantity: Int

    
    //MARK:- Init
    init(product: Product) {
        self.product = product
        self.selectedQuantity = 1
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
        cart.addProduct(product: product, quantity: selectedQuantity, options: productOptionsCartFormat())
    }
    
    func productOptionsCartFormat() -> [CartItemOptions]? {
        var cartOptions = [CartItemOptions]()
        for selection in selectedOptions {
            let option = self.optionHeader(at: selection.section)
            let variant = self.product.productOptions[selection.section - 1].variants.first {
                $0.identifier == selection.selectedVariant
            }
            let singleCartOption = CartItemOptions(optionId: option.identifier, variantId: variant!.identifier)
            cartOptions.append(singleCartOption)
        }
        
        return cartOptions
    }
    
    //MARK:- Product Details
    func increase() {
        let maxQuantity = product.maxQuantity
        if let cartItem = Cart.shared.cartItemsArr.filter({ $0.productId == String(product.identifier) }).first {
            if let max = Int(maxQuantity), max <= cartItem.count + selectedQuantity {
                // max reached
            } else {
                self.selectedQuantity += 1
            }
        } else {
            if let max = Int(maxQuantity), max <= selectedQuantity {
                // max reached
            } else {
                self.selectedQuantity += 1
            }
        }
        
    }
    
    func decrease() {
        if self.selectedQuantity > 1 {
            self.selectedQuantity -= 1
        }
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
        unselectAllIfFound(at: indexPath.section)
        self.selectedOptions.append(option)
        print("variant: \(variant)")
        print("section: \(indexPath.section)")
        print("selectedOptions: \(selectedOptions)")
    }
    
    func unselectOption(at indexPath: IndexPath) {
        let variant = optionVariant(at: indexPath)
        let foundOptions = self.selectedOptions.filter{ $0.section == indexPath.section && $0.selectedVariant == variant.identifier }
        if foundOptions.count > 0 {
            self.selectedOptions.removeAll(where: { $0.section == indexPath.section && $0.selectedVariant == variant.identifier })
        }
    }
    
    func unselectAllIfFound(at section: Int) {
        let foundOptions = self.selectedOptions.filter{ $0.section == section }
        if foundOptions.count > 0 {
            self.selectedOptions.removeAll(where: { $0.section == section })
        }
    }
    
    // MARK:- ProductDeatailsTableViewCellViewModel
    func detailsCellVM() -> ProductDeatailsTableViewCellViewModel {
        return ProductDeatailsTableViewCellViewModel(product: self.product)
    }
}

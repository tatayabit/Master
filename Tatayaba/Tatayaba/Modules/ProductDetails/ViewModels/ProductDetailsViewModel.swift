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
    var alsoBoughtProductsBlock: Block = Block()

    var optionsCount: Int { return self.product.productOptions.count }
    var numberOfAlsoBoughtProducts: Int { return self.alsoBoughtProductsBlock.products.count }
    
    var numberOfSections: Int {
        let numberOfAlsoBoughtSection = self.numberOfAlsoBoughtProducts > 0 ? 1: 0
        return optionsCount + numberOfAlsoBoughtSection + 1
    }
    
    var hasRequiredOptions: Bool {
        return product.productOptions.filter({ $0.required == "Y" }).count > 0
    }
    
    // Selection part
    private var selectedOptions = [OptionsSelection]()
    private var selectedQuantity: Int
    var inStock: Bool { return product.isInStock }

    
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
    
    func getAlsoBoughtProducts(completion: @escaping (APIResult<Block?, MoyaError>) -> Void) {
        
        apiClient.getAlsoBoughtProducts(productId: product.identifier) { result in
            switch result {
            case .success(let responseB44):
                guard let block = responseB44 else { return }
                var sortedBlock = block
                sortedBlock.products = block.products.sorted(by: { $0.fullDetails.position < $1.fullDetails.position })
                sortedBlock.products = sortedBlock.products.filter({ $0.fullDetails.amount > 0 })
                self.alsoBoughtProductsBlock = sortedBlock
                print(block)
        
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
        
        let maxQuantity = Int(product.maxQuantity) ?? 0
        let stockQuantity = product.amount
        var max = (stockQuantity > maxQuantity) ? maxQuantity : stockQuantity
        if product.isOutOfStockActionB {
            max = maxQuantity
        }
        
        if let cartItem = Cart.shared.cartItemsArr.filter({ $0.productId == String(product.identifier) }).first {
            if max <= cartItem.count + selectedQuantity {
                // max reached
            } else {
                self.selectedQuantity += 1
            }
        } else {
            if max <= selectedQuantity {
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
    
    func isAllRequiredOptionsSelected() -> Bool {
        if hasRequiredOptions {
            for section in 1..<optionsCount + 1 {
                let option = optionHeader(at: section)
                if option.required == "Y" {
                    if self.selectedOptions.filter({ $0.section == section }).count == 0 {
                        return false
                    }
                }
            }
        }
        return true
    }
    
    // MARK:- AlsoBoughtSection
    func isAlsoBoughtSection(section: Int) -> Bool {
        if numberOfAlsoBoughtProducts == 0 {
            return false
        }
        return section == numberOfSections - 1
    }
    
      
    func addToCartAlsoBoughtProduct(product: Product)  {
        let cart = Cart.shared
        cart.addProduct(product: product)
    }
    
    //MARK:- ProductDetails ViewModel
    func alsoBoughtProductDetailsViewModel(at indexPath: IndexPath) -> ProductDetailsViewModel {
        let productViewModel = ProductDetailsViewModel(product:self.alsoBoughtProductsBlock.products[indexPath.row].fullDetails)
        return productViewModel
    }
    
    // MARK:- ProductDeatailsTableViewCellViewModel
    func detailsCellVM() -> ProductDeatailsTableViewCellViewModel {
        return ProductDeatailsTableViewCellViewModel(product: self.product)
    }
}

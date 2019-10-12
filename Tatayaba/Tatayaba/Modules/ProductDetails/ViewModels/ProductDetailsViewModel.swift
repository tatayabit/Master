//
//  ProductDetailsViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/10/19.
//  Copyright © 2019 Shaik. All rights reserved.
//
import Moya

class ProductDetailsViewModel {

    let apiClient = ProductsAPIClient()

    private var product: Product
    private var recommendedList = [Product]()

    var name: String { return product.name }
    var description: String {
        if product.description.isEmpty {
            return "This is product is one of our best sellers"
        }
        return product.description }
    var price: String { return product.price.formattedPrice }
    var imageUrl: String { return product.mainPair.detailedPair.imageUrl }

    var selectedQuantity: Int
    var optionsCount: Int { return self.product.productOptions.count }

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
    func increase() {
        if self.selectedQuantity < 100 {
            self.selectedQuantity += 1
        }
    }

    func decrease() {
        if self.selectedQuantity > 1 {
            self.selectedQuantity -= 1
        }
    }

    func addToCart()  {
        let cart = Cart.shared
        cart.addProduct(product: product)
    }

    //MARK:- Product Options
    func option(at indexPath: IndexPath) -> ProductOption {
        return self.product.productOptions[indexPath.row]
    }
    
    func numberOfRows(at section: Int) -> Int {
        return self.product.productOptions[section].variants.count
    }
}

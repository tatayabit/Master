//
//  ProductDeatailsTableViewCellViewModel.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/13/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

class ProductDeatailsTableViewCellViewModel {
    private var product: Product
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
    
    
    // MARK:- Init
    init(product: Product) {
        self.product = product
        self.selectedQuantity = 1
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

    
}

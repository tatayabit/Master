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
        return product.description.stripOutHtml() }
    var price: String { return product.price.formattedPrice }
    var discountPercentage: String { return product.listPrice }
    var discountPrice: String {
        if let percentage = Float(product.listPrice), let priceFloat = Float(product.price) {
            if percentage > 0 {
                let discountValue = (percentage / 100) * priceFloat
                
                return String(priceFloat - discountValue).formattedPrice
            }
        }
        return "" }

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

    
}

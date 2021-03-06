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
            return ""
        }
        return product.description.stripOutHtml() }
    var originalPrice: String { return product.price.formattedPrice }
    var discountPercentage: String { return product.discountPercentage }
    var priceBeforeDiscount: String {
        if let priceBeforeDiscountFloat = Float(product.priceBeforeDiscount) {
            if priceBeforeDiscountFloat > 0 {
                return String(priceBeforeDiscountFloat).formattedPrice
            }
        }
        return "" }

    var hasDiscount: Bool {
        if let percentage = Float(discountPercentage) {
            return percentage > 0
        }
        return false }
    
    var imageUrl: String { return product.mainPair.detailedPair.imageUrl }
    
    var selectedQuantity: Int
    var optionsCount: Int { return self.product.productOptions.count }
    var isInStock: Bool { return self.product.isInStock }
    var supplierName : String { return self.product.supplierName }
    // MARK:- Init
    init(product: Product) {
        self.product = product
        self.selectedQuantity = 1
    }
    
    //MARK:- Product Details
    func increase() {
        
//        let maxQuantity = Int(cartProduct.0.maxQuantity) ?? 0
//        let stockQuantity = cartProduct.0.amount
//        let currentQuantity = cell.quantityCoutLabel.text ?? "0"
//        let max = (stockQuantity > maxQuantity) ? maxQuantity : stockQuantity
        
        
//        if  max <= Int(currentQuantity) ?? 0 {
//            // max reached
//        } else {
//            self.addOneMoreAction(indexPath: indexPath)
//            cell.updatePrice(product: cartProduct.0, cartItem: cartProduct.1)
//        }
        
        
        let maxQuantity = Int(product.maxQuantity) ?? 0
        let stockQuantity = product.amount
        
        
//        let max = Int(maxQuantity) ?? 0
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

    
}

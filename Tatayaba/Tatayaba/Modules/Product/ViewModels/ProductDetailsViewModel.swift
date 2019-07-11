//
//  ProductDetailsViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/10/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct ProductDetailsViewModel {
    private var product: Product
    private var recommendedList = [Product]()

    var name: String { return product.name }
    var description: String { return product.description }
    var price: String { return product.price }

    var selectedQuantity: Int

    //MARK:- Init
    init(product: Product) {
        self.product = product
        self.selectedQuantity = 1
    }

    //MARK:- Product Details
    mutating func increase() {
        if self.selectedQuantity < 100 {
            self.selectedQuantity += 1
        }
    }

    mutating func decrease() {
        if self.selectedQuantity > 1 {
            self.selectedQuantity -= 1
        }
    }
}

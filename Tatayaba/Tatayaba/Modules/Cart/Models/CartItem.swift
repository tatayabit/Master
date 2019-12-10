//
//  CartItem.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/22/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct CartItemOptions {
    var optionId: String
    var variantId: String
}

extension CartItemOptions: Codable {
    enum CodingKeys: String, CodingKey {
          case optionId
          case variantId
      }


    init(from decoder: Decoder) throws {
          let container = try decoder.container(keyedBy: CodingKeys.self)

          optionId = try container.decodeIfPresent(String.self, forKey: .optionId) ?? ""
          variantId = try container.decodeIfPresent(String.self, forKey: .variantId) ?? ""
      }

      func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: CodingKeys.self)

          try container.encodeIfPresent(optionId, forKey: .optionId)
          try container.encodeIfPresent(variantId, forKey: .variantId)
      }
}

class CartItem {
    var productId: String
    var productName: String
    var options: [CartItemOptions]?
    var count: Int = 0

    private let maxCount = 99
    private let minCount = 0

    init(productId: String = "" , productName: String = "", quantity: Int = 1, options: [CartItemOptions]? = nil) {
        self.productId = productId
        self.productName = productName
        self.increaseCount(by: quantity)
        self.options = options
    }

    func increaseCount(by value: Int) {
        if count < maxCount {
            self.count += value
        }
    }

    func decreaseCount(by value: Int) {
        if count > minCount {
            self.count -= value
        }
    }


}

extension CartItem: Codable {
    enum CodingKeys: String, CodingKey {
          case productId
          case productName
          case options
          case count
      }

    
    convenience init(from decoder: Decoder) throws {
        self.init()
        let container = try decoder.container(keyedBy: CodingKeys.self)
        productId = try container.decodeIfPresent(String.self, forKey: .productId) ?? ""
        productName = try container.decodeIfPresent(String.self, forKey: .productName) ?? ""
        options = try container.decodeIfPresent([CartItemOptions].self, forKey: .options)
        count = try container.decodeIfPresent(Int.self, forKey: .count) ?? 0
      }

      func encode(to encoder: Encoder) throws {
          var container = encoder.container(keyedBy: CodingKeys.self)

          try container.encodeIfPresent(productId, forKey: .productId)
          try container.encodeIfPresent(productName, forKey: .productName)
          try container.encodeIfPresent(options, forKey: .options)
          try container.encodeIfPresent(count, forKey: .count)
      }
}

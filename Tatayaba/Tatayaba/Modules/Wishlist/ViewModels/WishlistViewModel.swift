//
//  WishlistViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/11/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

struct WishlistViewModel {
    private var wishlistProducts = [Product]()

    /// This closure is being called once the wishlist api fetch
    var onWishlistProductsLoad: (() -> ())?

    var wishlistCount: Int {
        return wishlistProducts.count
    }

    //MARK:- Categories data
    func wishlistProduct(at indexPath: IndexPath) -> Product {
        guard wishlistProducts.count > 0 else { return Product() }
        return wishlistProducts[indexPath.row]
    }
}

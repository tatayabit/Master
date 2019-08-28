//
//  HomeViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/8/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

class HomeViewModel {

    private let productsApiClient = ProductsAPIClient()
    private let blocksApiClient = BlocksAPIClient()


    private var categoriesList = [Category]()
    private var featuredProductsList = [Product]()

    var topBannersBlock: Block = Block()
    

    /// This closure is being called once the categories api fetch
    var onCategoriesListLoad: (() -> ())?

    /// This closure is being called once the featured products api fetch
    var onFeaturedProductsListLoad: (() -> ())?

    /// This closure is being called once the banners block api fetch
    var onTopBannersBlockLoad: (() -> ())?

    var categoriesCount: Int { return categoriesList.count }
    var featuredProductsCount: Int { return featuredProductsList.count }

    //MARK:- Init
    func loadAPIs() {
        getAllCategories()
        getFeaturedProducts()
        getBlock58()
    }

    //MARK:- Api

    func getAllCategories() {
        productsApiClient.getAllCategories { result in
            switch result {
            case .success(let response):
                guard let categoriesResult = response else { return }
                guard let categories = categoriesResult.categories else { return }

                self.categoriesList = categories.filter({ $0.parentId == "0" })
                print(categories)


                if let newCategoriesArrived = self.onCategoriesListLoad {
                    newCategoriesArrived()
                }
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

    func getFeaturedProducts() {
        productsApiClient.getProductFeatures { result in
            switch result {
            case .success(let response):
                guard let productsResult = response else { return }
                guard let products = productsResult.products else { return }

                self.featuredProductsList = products
                print(products)


                if let newfeaturedProductsArrived = self.onFeaturedProductsListLoad {
                    newfeaturedProductsArrived()
                }
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

    func getBlock58() {
        blocksApiClient.getBlock(blockId: "246") { result in
//            58
            switch result {
            case .success(let responseB58):
                guard let block = responseB58 else { return }
                self.topBannersBlock = block
                print(block)

                if let newBannersArrived = self.onTopBannersBlockLoad {
                    newBannersArrived()
                }
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

    //MARK:- Categories data
    func category(at indexPath: IndexPath) -> Category {
        guard categoriesList.count > 0 else { return Category() }
        return categoriesList[indexPath.row]
    }

    //MARK:- featured Product data
    func featuredProduct(at indexPath: IndexPath) -> Product {
        guard featuredProductsList.count > 0 else { return Product() }
        return featuredProductsList[indexPath.row]
    }

    //MARK:- Parsing Deeplink
    func parseDeeplink(at indexPath: IndexPath) {
        guard topBannersBlock.banners.count > 0 else { return }
        let banner = topBannersBlock.banners[indexPath.row]

        let deeplink = DeeplinkHandler(urlString: banner.url, type: .category)
        deeplink.parse()
    }


    //MARK:- ProductDetails ViewModel
    func productDetailsViewModel(at indexPath: IndexPath) -> ProductDetailsViewModel {
        let productViewModel = ProductDetailsViewModel(product: featuredProduct(at: indexPath))
        return productViewModel
    }
}

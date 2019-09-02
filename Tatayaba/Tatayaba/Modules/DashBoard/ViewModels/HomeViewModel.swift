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
    private let suppliersApiClient = SuppliersAPIClient()


    var categoriesList = [Category]()
    var suppliersList = [Supplier]()

    private var featuredProductsList = [Product]()

    var topBannersBlock: Block = Block()
    var productsBlock: Block = Block()

    /// This closure is being called once the categories api fetch
    var onCategoriesListLoad: (() -> ())?

    /// This closure is being called once the featured products api fetch
    var onFeaturedProductsListLoad: (() -> ())?

    /// This closure is being called once the banners block api fetch
    var onTopBannersBlockLoad: (() -> ())?

    /// This closure is being called once the products block api fetch
    var onProductsBlockLoad: (() -> ())?


    var onSuppliersBlockLoad: (() -> ())?

    var featuredProductsCount: Int { return featuredProductsList.count }

    //MARK:- Init
    func loadAPIs() {
        getAllCategories()
        getFeaturedProducts()
        getBlock58()
        getBlock44()
        getAllSuppliers()
    }

    //MARK:- Api

    func getAllCategories() {
        productsApiClient.getAllCategories { result in
            switch result {
            case .success(let response):
                guard let categoriesResult = response else { return }
                //                guard let categories = categoriesResult else { return }

                self.categoriesList = categoriesResult//.filter({ $0.parentId == "0" })

                print(self.categoriesList)


                if let newCategoriesArrived = self.onCategoriesListLoad {
                    newCategoriesArrived()
                }
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

    func getAllSuppliers() {
        suppliersApiClient.getSuppliers { result in
            switch result {
            case .success(let response):
                guard let suppliersResult = response else { return }
                guard let suppliers = suppliersResult.suppliers else { return }

                self.suppliersList = suppliers
                print("suppliers: \(suppliers)")


                if let newSuppliersArrived = self.onSuppliersBlockLoad {
                    newSuppliersArrived()
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
        // 246 banners
        blocksApiClient.getBlock(blockId: "246") { result in
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

    func getBlock44() {
        // 44 products
        blocksApiClient.getBlock(blockId: "44") { result in
            //            58
            switch result {
            case .success(let responseB44):
                guard let block = responseB44 else { return }
                self.productsBlock = block
                print(block)

                if let newBannersArrived = self.onProductsBlockLoad {
                    newBannersArrived()
                }
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

    //MARK:- Categories data
    func category(at indexPath: IndexPath) -> Category {
        guard categoriesList.count > 0 else { return Category(identifier: "0") }
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

    //MARK:- ProductsListViewModel
    func productsListViewModel(indexPath: IndexPath) -> ProductsListViewModel {
        let category = categoriesList[indexPath.row]
        return ProductsListViewModel(categoryId: Int(category.identifier) ?? 0)
    }
}

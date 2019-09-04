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


    var topBannersBlock: Block = Block()
    var squareBlock: Block = Block()

    /// This closure is being called once the categories api fetch
    var onCategoriesListLoad: (() -> ())?

    /// This closure is being called once the banners block api fetch
    var onTopBannersBlockLoad: (() -> ())?

    /// This closure is being called once the square block api fetch
    var onSquareBlockLoad: (() -> ())?


    var onSuppliersBlockLoad: (() -> ())?


    //MARK:- Init
    func loadAPIs() {
        getAllCategories()
        loadTopBannerApi()
        getSquaredBlock()
        getAllSuppliers()
    }

    //MARK:- Api

    func getAllCategories() {
        productsApiClient.getAllCategories { result in
            switch result {
            case .success(let response):
                guard let categoriesResult = response else { return }
                guard let categories = categoriesResult.categories else { return }

                self.categoriesList = categories//.filter({ $0.parentId == "0" })

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

    func loadTopBannerApi() {
        // topBannerApi
        blocksApiClient.getBlock(blockId: "259") { result in
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

    func getSquaredBlock() {
        // squaredBlock
        blocksApiClient.getBlock(blockId: "269") { result in
            // 259
            switch result {
            case .success(let responseB44):
                guard let block = responseB44 else { return }
                self.squareBlock = block
                print(block)

                if let newBannersArrived = self.onSquareBlockLoad {
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

    //MARK:- Parsing Deeplink
    func parseDeeplink(at indexPath: IndexPath) {
//        guard topBannersBlock.banners.count > 0 else { return }
//        let banner = topBannersBlock.banners[indexPath.row]
//
//        let deeplink = DeeplinkHandler(urlString: banner.url, type: .category)
//        deeplink.parse()
    }


    //MARK:- ProductDetails ViewModel
//    func productDetailsViewModel(at indexPath: IndexPath) -> ProductDetailsViewModel {
//        let productViewModel = ProductDetailsViewModel(product: featuredProduct(at: indexPath))
//        return productViewModel
//    }

    //MARK:- ProductsListViewModel
    func productsListViewModel(indexPath: IndexPath) -> ProductsListViewModel {
        let category = categoriesList[indexPath.row]
        return ProductsListViewModel(categoryId: Int(category.identifier) ?? 0)
    }
}

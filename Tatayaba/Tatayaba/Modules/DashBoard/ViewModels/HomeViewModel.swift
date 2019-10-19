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

    var productsBlock: Block = Block()


    /// This closure is being called once the categories api fetch
    var onCategoriesListLoad: (() -> ())?

    /// This closure is being called once the banners block api fetch
    var onTopBannersBlockLoad: (() -> ())?

    /// This closure is being called once the square block api fetch
    var onSquareBlockLoad: (() -> ())?

    /// This closure is being called once the products block api fetch
    var onProductsBlockLoad: (() -> ())?


    var onSuppliersBlockLoad: (() -> ())?


    //MARK:- Init
    func loadAPIs() {
        getAllCategories()
        loadTopBannerApi()
        getSquaredBlock()
        getAllSuppliers()
        getProductBlock()
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.getAllCategories()
                })

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

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                    self.getAllSuppliers()
                })

            }
        }
    }

    func loadTopBannerApi() {
        // topBannerApi
        blocksApiClient.getBlock(blockId: "242") { result in
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                    self.loadTopBannerApi()
                })

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
                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                    self.getSquaredBlock()
                })

            }
        }
    }

    func getProductBlock() {
        // squaredBlock
        blocksApiClient.getBlock(blockId: "268") { result in
            // 258
            switch result {
            case .success(let responseB44):
                guard let block = responseB44 else { return }
                self.productsBlock = block
                print(block)

                if let newProductsArrived = self.onProductsBlockLoad {
                    newProductsArrived()
                }
            case .failure(let error):
                print("the error \(error)")
//                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
//                    self.getProductBlock()
//                })
            }
        }
    }

    //MARK:- Categories data
    func category(at indexPath: IndexPath) -> Category {
        guard categoriesList.count > 0 else { return Category(identifier: "0") }
        return categoriesList[indexPath.row]
    }

    //MARK:- Parsing Deeplink
    func parseSquareBlockDeeplink(at indexPath: IndexPath) -> DeepLinkModel {
        guard squareBlock.banners.count > 0 else { return DeepLinkModel(type: .unknown, id: "") }
        let banner = squareBlock.banners[indexPath.row]

        let deeplink = DeeplinkHandler(urlString: banner.url)
        let result = deeplink.parse()
        return result
    }
    
    func parsetopBannersBlockDeeplink(at indexPath: IndexPath) -> DeepLinkModel {
           guard topBannersBlock.banners.count > 0 else { return DeepLinkModel(type: .unknown, id: "") }
           let banner = topBannersBlock.banners[indexPath.row]

           let deeplink = DeeplinkHandler(urlString: banner.url)
           let result = deeplink.parse()
           return result
       }


    // MARK:- AddToCart
    func addToCart(product: Product)  {
        let cart = Cart.shared
        cart.addProduct(product: product)
    }

    //MARK:- ProductDetails ViewModel
    func productDetailsViewModel(at indexPath: IndexPath) -> ProductDetailsViewModel {
        let productViewModel = ProductDetailsViewModel(product: productsBlock.products[indexPath.row].fullDetails)
        return productViewModel
    }

    //MARK:- ProductsListViewModel
    func catProductsListViewModel(indexPath: IndexPath) -> CatProductsViewModel {
        let category = categoriesList[indexPath.row]
        return CatProductsViewModel(category: category)
    }
    
    func catProductsListViewModel(with id: String) -> CatProductsViewModel {
        let category = Category(identifier: id)
        return CatProductsViewModel(category: category)
    }

    //MARK:- SupplierProductsViewModel
    func supplierProductsViewModel(indexPath: IndexPath) -> SupplierProductsViewModel {
        let supplier = suppliersList[indexPath.row]
        return SupplierProductsViewModel(supplier: supplier)
    }
}

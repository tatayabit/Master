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


    //let productIdList = ["268","270","305", "267", "297", "248", "265"]
//    let productIdList = ["314","320","315", "316", "317", "318", "319"]
    let productIdList = ["268","270","297", "248", "265", "272", "260"]
    var block_Id = ""
    var categoriesList = [Category]()
    var suppliersList = [Supplier]()


    var topBannersBlock: Block = Block()
    var squareBlock: Block = Block()

    var productsBlocks = [Block]()

    let validApiClient = VersionValidationAPIClient()
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
        DispatchQueue.background(delay: 0.0, background: {
            self.getAllCategories()
            self.loadTopBannerApi()
            self.getSquaredBlock()
            self.getAllSuppliers()
            self.getProductBlock()
        })
    }

    //MARK:- Api
    func getAllCategories() {
        productsApiClient.getAllCategories { result in
            switch result {
            case .success(let response):
                guard let categoriesResult = response else { return }
                guard let categories = categoriesResult.categories else { return }

                self.categoriesList = categories.sorted(by: { Int($0.position) ?? 0 < Int($1.position) ?? 0 }) .filter({ $0.parentId == "0" })

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
        suppliersApiClient.getSuppliersSortedByPosition(page: 0) { result in
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
        blocksApiClient.getBlock(blockId: "312") { result in      //242
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
        blocksApiClient.getBlock(blockId: "313") { result in    //269
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
        for id in productIdList {
            // squaredBlock
                    blocksApiClient.getBlock(blockId: id) { result in
                        // 258
                        switch result {
                        case .success(let responseB44):
                            guard let block = responseB44 else { return }
                            var sortedBlock = block
                            sortedBlock.products = block.products.sorted(by: { $0.fullDetails.position < $1.fullDetails.position })
                            sortedBlock.products = sortedBlock.products.filter({ $0.fullDetails.amount > 0 })
                            self.productsBlocks.append(sortedBlock)
                            print(block)
                            if (self.productsBlocks.count > 6) {
                                self.productsBlocks = self.arrangeProductsBlocks()
                                if let newProductsArrived = self.onProductsBlockLoad {
                                    newProductsArrived()
                                }
                            }

                            
                        case .failure(let error):
                            print("the error \(error)")
            //                DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            //                    self.getProductBlock()
            //                })
                        }
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
        guard squareBlock.banners.count > 0 else { return DeepLinkModel(type: .unknown, id: "", title: "") }
        let banner = squareBlock.banners[indexPath.row]

        let deeplink = DeeplinkHandler(urlString: banner.url)
        let result = deeplink.parse()
        return result
    }
    
    func parsetopBannersBlockDeeplink(at indexPath: IndexPath) -> DeepLinkModel {
        guard topBannersBlock.banners.count > 0 else { return DeepLinkModel(type: .unknown, id: "", title: "") }
           let banner = topBannersBlock.banners[indexPath.row]

           let deeplink = DeeplinkHandler(urlString: banner.url)
           let result = deeplink.parse()
           return result
       }

    // MARK:- HasRequiredOptions
    func hasOptions(at indexPath: IndexPath) -> Bool {
        let product = productsBlocks[0].products[indexPath.row].fullDetails
        return product.hasOptions
    }
    
    // MARK:- AddToCart
    func addToCart(product: Product)  {
        let cart = Cart.shared
        cart.addProduct(product: product)
    }
    
    func productInStock(at product: Product) -> Bool {
        return product.isInStock
    }

    //MARK:- ProductDetails ViewModel
    func productDetailsViewModel(at indexPath: IndexPath) -> ProductDetailsViewModel {
        let selectedBlock = getSelectedProductBlock()
        let productViewModel = ProductDetailsViewModel(product: selectedBlock.products[indexPath.row].fullDetails)
        return productViewModel
    }

    //MARK:- ProductsListViewModel
    func catProductsListViewModel(indexPath: IndexPath) -> CatProductsViewModel {
        let category = categoriesList[indexPath.row]
        return CatProductsViewModel(category: category)
    }
    
    func catProductsListViewModel(with id: String, title: String) -> CatProductsViewModel {
        var category = Category(identifier: id)
        category.name = title
        return CatProductsViewModel(category: category)
    }

    //MARK:- SupplierProductsViewModel
    func supplierProductsViewModel(indexPath: IndexPath) -> SupplierProductsViewModel {
        let supplier = suppliersList[indexPath.row]
        return SupplierProductsViewModel(supplier: supplier)
    }
    
    func getSelectedProductBlock() -> Block {
        for block in productsBlocks {
            if (block.blockId == self.block_Id) {
                return block
            }
        }
        return productsBlocks[0]
    }
    
    func arrangeProductsBlocks() -> [Block] {
        var block0 = Block()
        var block1 = Block()
        var block2 = Block()
        var block3 = Block()
        var block4 = Block()
        var block5 = Block()
        var block6 = Block()
        
        var tempProductsBlocks = [block0,block1,block2,block3,block4,block5,block6]
        for block in self.productsBlocks {
            switch block.blockId {
            case "268":
                tempProductsBlocks[0] = block
            case "270":
                tempProductsBlocks[1] = block
            case "297":
                tempProductsBlocks[2] = block
            case "248":
                tempProductsBlocks[3] = block
            case "265":
                tempProductsBlocks[4] = block
            case "272":
                tempProductsBlocks[5] = block
            case "260":
                tempProductsBlocks[6] = block
            default:
                print("Error in arrangment of ProductsBlocks")
            }
        }
        return tempProductsBlocks
    }
    
    // validate API version   validApiClient
    
    func ValidateVersionVersion(completion: @escaping (String) -> ()){
        let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        print(appVersion)
        //CFBundleShortVersionString //CFBundleVersion
        validApiClient.getVersionValidation(version: appVersion ?? "4.3.1"){
            result in
            switch result {
            case .success(let response):
                print("Sucess")
                guard let vResponse = response else { return }
                if let test = vResponse["status"]{
                    completion(test)
                }

            case .failure(let error):
                print("the error \(error)")
                completion("success")
            }
        }
    }
    
    func openStoreURL() {
        //"https://www.apple.com/kw/ios/app-store/"
        let arURL = "https://apps.apple.com/us/app/tatayab-تطي-ب/id1394093760/"
        let url =  arURL.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)

        if let url = URL(string: arURL.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? "https://www.apple.com/kw/ios/app-store/"),
            UIApplication.shared.canOpenURL(url)   //itms-apps://itunes.apple.com/app/id1024941703
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}


//
//  SplashViewModel.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 1/29/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//

import Moya

class SplashViewModel {
    private let productsApiClient = ProductsAPIClient()
    private let blocksApiClient = BlocksAPIClient()
    private let suppliersApiClient = SuppliersAPIClient()
    
    private let productIdList = ["268","293","270","297", "248", "265", "272", "260"]

    var categoriesList = [Category]()
    var suppliersList = [Supplier]()
    var topBannersBlock: Block = Block()
    var squareBlock: Block = Block()
    var productsBlocks = [Block]()
    
    
    //MARK:- APIs
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


//                if let newCategoriesArrived = self.onCategoriesListLoad {
//                    newCategoriesArrived()
//                }
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


//                if let newSuppliersArrived = self.onSuppliersBlockLoad {
//                    newSuppliersArrived()
//                }
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

//                if let newBannersArrived = self.onTopBannersBlockLoad {
//                    newBannersArrived()
//                }
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

//                if let newBannersArrived = self.onSquareBlockLoad {
//                    newBannersArrived()
//                }
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
                            let sortedBlock = block
                            if (block.products.count == 0){
                                print("catch")
                            }
                            self.productsBlocks.append(sortedBlock)
                            print(block)
                            if (self.productsBlocks.count > 7) {
                                self.productsBlocks = self.arrangeProductsBlocks()
//                                if let newProductsArrived = self.onProductsBlockLoad {
//                                    newProductsArrived()
//                                }
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
    
    // MARK:- Arrange Products Blocks
    func arrangeProductsBlocks() -> [Block] {
        let block0 = Block()
        let block1 = Block()
        let block2 = Block()
        let block3 = Block()
        let block4 = Block()
        let block5 = Block()
        let block6 = Block()
        let block7 = Block()
        
        var tempProductsBlocks = [block0,block1,block2,block3,block4,block5,block6,block7]
        for block in self.productsBlocks {
            switch block.blockId {
            case "268":
                tempProductsBlocks[0] = block
            case "293":
                tempProductsBlocks[1] = block
            case "270":
                tempProductsBlocks[2] = block
            case "297":
                tempProductsBlocks[3] = block
            case "248":
                tempProductsBlocks[4] = block
            case "265":
                tempProductsBlocks[5] = block
            case "272":
                tempProductsBlocks[6] = block
            case "260":
                tempProductsBlocks[7] = block
            default:
                print("Error in arrangment of ProductsBlocks")
            }
        }
        return tempProductsBlocks
    }
}

//
//  HomeViewController.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController, BannersBlocksViewProtocol, CategoriesBlockViewProtocol {


    private let productDetailsSegue = "product_details_segue"
    private let categoryProductsSegue = "category_products_segue"
    private let allCategoriesSegue = "all_categories_segue"

    @IBOutlet weak var scrollView: StackedScrollView!

    private var viewModel = HomeViewModel()

    let bannersBlockView: BannersBlocksView = .fromNib()
    let bannersCarouselView: BannersCarouselView = .fromNib()
    let fullScreenBannersView: FullScreenBannersView = .fromNib()
    let categoriesBlockView: CategoriesBlockView = .fromNib()
    let suppliersBlockView: SuppliersBlockView = .fromNib()


    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addBannersSubView()
        setupListners()
        setupUI()
        viewModel.loadAPIs()
    }

    fileprivate func addBannersSubView() {
        scrollView.stackView.addArrangedSubview(fullScreenBannersView)
        fullScreenBannersView.translatesAutoresizingMaskIntoConstraints = false
        fullScreenBannersView.heightAnchor.constraint(equalToConstant: 150).isActive = true

        categoriesBlockView.delegate = self
        scrollView.stackView.addArrangedSubview(categoriesBlockView)
        categoriesBlockView.translatesAutoresizingMaskIntoConstraints = false
        categoriesBlockView.heightAnchor.constraint(equalToConstant: 115).isActive = true


        bannersBlockView.delegate = self
        scrollView.stackView.addArrangedSubview(bannersBlockView)
        bannersBlockView.translatesAutoresizingMaskIntoConstraints = false
        bannersBlockView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        bannersBlockView.titleLabel.text = "Trending on Tatayab"

        scrollView.stackView.addArrangedSubview(bannersCarouselView)
        bannersCarouselView.translatesAutoresizingMaskIntoConstraints = false
        bannersCarouselView.heightAnchor.constraint(equalToConstant: 200).isActive = true


        scrollView.stackView.addArrangedSubview(suppliersBlockView)
        suppliersBlockView.translatesAutoresizingMaskIntoConstraints = false
        suppliersBlockView.heightAnchor.constraint(equalToConstant: 115).isActive = true

    }

    fileprivate func loadBannersBlockViewData() {
        bannersBlockView.block = viewModel.topBannersBlock
        bannersBlockView.loadData()
    }


    fileprivate func loadBannersCarouselViewData() {
        bannersCarouselView.bannerType = .product
        bannersCarouselView.block = viewModel.productsBlock
        bannersCarouselView.loadData()
    }

    fileprivate func loadFullScreenBannersViewData() {
        fullScreenBannersView.block = viewModel.topBannersBlock
        fullScreenBannersView.loadData()
    }

    fileprivate func loadCategoriesBlockViewData() {
        categoriesBlockView.categories = viewModel.categoriesList
        categoriesBlockView.loadData()
    }

    fileprivate func loadSuppliersBlockViewData() {
        suppliersBlockView.suppliers = viewModel.suppliersList
        suppliersBlockView.loadData()
    }


    func setupListners() {
        viewModel.onCategoriesListLoad = {
//            self.setupBannersCarouselView()
            self.loadCategoriesBlockViewData()
        }

        viewModel.onProductsBlockLoad = {
            self.loadBannersCarouselViewData()
        }

        viewModel.onTopBannersBlockLoad = {
            self.loadFullScreenBannersViewData()
            self.loadBannersBlockViewData()
        }

        viewModel.onSuppliersBlockLoad = {
            self.loadSuppliersBlockViewData()
        }

        viewModel.onFeaturedProductsListLoad = {
//            self.collectionView.delegate = self
//            self.collectionView.dataSource = self
//            self.collectionView.reloadData()
        }
    }

    // MARK:- SetupUI
    func setupUI() {
        self.scrollView.stackView.spacing = 10
        self.scrollView.stackView.backgroundColor = .clear
        self.scrollView.backgroundColor = .clear

        self.addLeftBarButton()
        self.NavigationBarWithOutBackButton()
    }

    // MARK:- CategoriesBlockView delegate
    func didSelectCategory(at indexPath: IndexPath) {
        performSegue(withIdentifier: categoryProductsSegue, sender: indexPath)
    }
    
    func didSelectBannerBlocks(at indexPath: IndexPath) {
        viewModel.parseDeeplink(at: indexPath)
    }
}

extension HomeViewController {

    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == productDetailsSegue {
            let productDetailsVC = segue.destination as! ProductDetailsViewController
            if let indexPath = sender as? IndexPath {
                productDetailsVC.viewModel = viewModel.productDetailsViewModel(at: indexPath)
            }
        }

        if segue.identifier == categoryProductsSegue {
            let productsListVC = segue.destination as! ProductsListViewController
            if let indexPath = sender as? IndexPath {
                productsListVC.viewModel = viewModel.productsListViewModel(indexPath: indexPath)
            }
        }



    }

}


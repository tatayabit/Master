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

    let squaredBlockView: BannersBlocksView = .fromNib()
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


        squaredBlockView.delegate = self
        scrollView.stackView.addArrangedSubview(squaredBlockView)
        squaredBlockView.translatesAutoresizingMaskIntoConstraints = false
        squaredBlockView.heightAnchor.constraint(equalToConstant: 280).isActive = true

        scrollView.stackView.addArrangedSubview(bannersCarouselView)
        bannersCarouselView.translatesAutoresizingMaskIntoConstraints = false
        bannersCarouselView.heightAnchor.constraint(equalToConstant: 200).isActive = true


        scrollView.stackView.addArrangedSubview(suppliersBlockView)
        suppliersBlockView.translatesAutoresizingMaskIntoConstraints = false
        suppliersBlockView.heightAnchor.constraint(equalToConstant: 115).isActive = true

    }

    fileprivate func loadSquaredBlockViewData() {
        squaredBlockView.block = viewModel.squareBlock
        squaredBlockView.loadData()
        squaredBlockView.titleLabel.text = "Trending on Tatayab"
        squaredBlockView.viewAllButton.isHidden = true
    }


    fileprivate func loadBannersCarouselViewData() {
        bannersCarouselView.bannerType = .product
        bannersCarouselView.block = viewModel.squareBlock
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
            self.loadCategoriesBlockViewData()
        }

        viewModel.onSquareBlockLoad = {
            self.loadSquaredBlockViewData()
        }

        viewModel.onTopBannersBlockLoad = {
            self.loadFullScreenBannersViewData()
        }

        viewModel.onSuppliersBlockLoad = {
            self.loadSuppliersBlockViewData()
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
//            if let indexPath = sender as? IndexPath {
//                productDetailsVC.viewModel = viewModel.productDetailsViewModel(at: indexPath)
//            }
        }

        if segue.identifier == categoryProductsSegue {
            let productsListVC = segue.destination as! ProductsListViewController
            if let indexPath = sender as? IndexPath {
                productsListVC.viewModel = viewModel.productsListViewModel(indexPath: indexPath)
            }
        }



    }

}


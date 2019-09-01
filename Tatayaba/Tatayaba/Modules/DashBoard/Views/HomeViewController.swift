//
//  HomeViewController.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController,AACarouselDelegate, BannersBlocksViewProtocol {

    private let productDetailsSegue = "product_details_segue"

    @IBOutlet weak var scrollView: StackedScrollView!

    private var viewModel = HomeViewModel()

    let bannersBlockView: BannersBlocksView = .fromNib()
    let bannersCarouselView: BannersCarouselView = .fromNib()
    let fullScreenBannersView: FullScreenBannersView = .fromNib()
    let categoriesBlockView: CategoriesBlockView = .fromNib()


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

//        categoriesBlockView.delegate = self
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

        viewModel.onFeaturedProductsListLoad = {
//            self.collectionView.delegate = self
//            self.collectionView.dataSource = self
//            self.collectionView.reloadData()
        }
    }
    func downloadImages(_ url: String, _ index: Int) {

    }

    // MARK:- SetupUI
    func setupUI() {
        self.scrollView.stackView.spacing = 0
        self.addLeftBarButton()
        self.NavigationBarWithOutBackButton()
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
    }

}


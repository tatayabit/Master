//
//  HomeViewController.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController,AACarouselDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, BannersBlocksViewProtocol {

    let buttonPadding:CGFloat = 05
    var xOffset:CGFloat = 15
    private let productDetailsSegue = "product_details_segue"

    @IBOutlet weak var scrollView: StackedScrollView!

    private var viewModel = HomeViewModel()
    let bannersBlockView: BannersBlocksView = .fromNib()
    let bannersCarouselView: BannersCarouselView = .fromNib()
    let fullScreenBannersView: FullScreenBannersView = .fromNib()



    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListners()
        setupUI()
        viewModel.loadAPIs()
    }

    fileprivate func setupBannersBlockView() {
        bannersBlockView.block = viewModel.topBannersBlock
        bannersBlockView.loadData()
        bannersBlockView.delegate = self
        scrollView.stackView.addArrangedSubview(bannersBlockView)
        bannersBlockView.translatesAutoresizingMaskIntoConstraints = false
        bannersBlockView.heightAnchor.constraint(equalToConstant: 280).isActive = true
    }


    fileprivate func setupBannersCarouselView() {
        bannersCarouselView.block = viewModel.topBannersBlock
        bannersCarouselView.loadData()
        scrollView.stackView.addArrangedSubview(bannersCarouselView)
        bannersCarouselView.translatesAutoresizingMaskIntoConstraints = false
        bannersCarouselView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }

    fileprivate func setupFullScreenBannersViewView() {
        fullScreenBannersView.block = viewModel.topBannersBlock
        fullScreenBannersView.loadData()
        scrollView.stackView.addArrangedSubview(fullScreenBannersView)
        fullScreenBannersView.translatesAutoresizingMaskIntoConstraints = false
        fullScreenBannersView.heightAnchor.constraint(equalToConstant: 130).isActive = true
    }


    func setupListners() {
        viewModel.onCategoriesListLoad = {
//            self.setupBannersCarouselView()
        }

        viewModel.onTopBannersBlockLoad = {
            self.setupFullScreenBannersViewView()
            self.setupBannersBlockView()
            self.setupBannersCarouselView()

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
        self.addLeftBarButton()
        self.NavigationBarWithOutBackButton()
//        self.collectionView.register(FeatureProductCollectionViewCell.nib, forCellWithReuseIdentifier: FeatureProductCollectionViewCell.identifier)
//        CategoriesView()
    }

    func didSelectBannerBlocks(at indexPath: IndexPath) {
        viewModel.parseDeeplink(at: indexPath)
    }
}

extension HomeViewController {
    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {

        return viewModel.featuredProductsCount
    }


    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {


        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureProductCollectionViewCell.identifier, for: indexPath) as! FeatureProductCollectionViewCell
        cell.configure(product: viewModel.featuredProduct(at: indexPath))

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 02, left: 0, bottom: 07, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

        return 10
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        print(indexPath.row)

        performSegue(withIdentifier: productDetailsSegue, sender: indexPath)

    }

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


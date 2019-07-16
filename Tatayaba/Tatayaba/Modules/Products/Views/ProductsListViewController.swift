//
//  ProductsListViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProductsListViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var productsCollectionView: UICollectionView!

    var viewModel: ProductsListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        setupUI()
        guard let viewModel = viewModel else { return }
        viewModel.getProductsOfCategory()
        viewModel.onProductsListLoad = {
            self.productsCollectionView.dataSource = self
            self.productsCollectionView.delegate = self
        }

    }

    func setupUI() {
        productsCollectionView.register(ProductCollectionViewCell.nib, forCellWithReuseIdentifier: ProductCollectionViewCell.identifier)
    }

    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.productsCount
    }


    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeatureProductCollectionViewCell.identifier, for: indexPath) as! FeatureProductCollectionViewCell
        guard let viewModel = viewModel else { return cell }

        cell.configure(product: viewModel.product(at: indexPath))

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: (self.view.bounds.width - 32) / 3, height: 154)
    }

}

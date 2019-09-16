//
//  ProductsListViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CatProductsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProductsBlockCollectionViewCellDelegate {

    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var categoryNameLabel: UILabel!

    var viewModel: CatProductsViewModel?
    private let productDetailsSegue = "product_details_segue"


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
        productsCollectionView.register(ProductsBlockCollectionViewCell.nib, forCellWithReuseIdentifier: ProductsBlockCollectionViewCell.identifier)
        self.categoryNameLabel.text = viewModel?.category.name
    }

    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.productsCount
    }


    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsBlockCollectionViewCell.identifier, for: indexPath) as! ProductsBlockCollectionViewCell
        guard let viewModel = viewModel else { return cell }

        cell.configure(viewModel.product(at: indexPath), indexPath: indexPath)
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: productDetailsSegue, sender: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.view.bounds.width / 2, height: 245)
    }

    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == productDetailsSegue {
            let productDetailsVC = segue.destination as! ProductDetailsViewController
            if let indexPath = sender as? IndexPath {
                if let viewModel = viewModel {
                    productDetailsVC.viewModel = viewModel.productDetailsViewModel(at: indexPath)
                }
            }
        }
    }

    // MARK:- ProductsBlockCollectionViewCellDelegate
    func didSelectAddToCartCell(indexPath: IndexPath) {
        viewModel?.addToCart(at: indexPath)
    }

}

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

        self.NavigationBarWithBackButton()

        setupUI()
        self.productsCollectionView.dataSource = self
        self.productsCollectionView.delegate = self
//        self.productsCollectionView.prefetchDataSource = self

        
        guard let viewModel = viewModel else { return }
        self.showLoadingIndicator(to: self.view)
        viewModel.setDelegate(self)
        viewModel.fetchModerators()

//        viewModel.getProductsOfCategory { result in
//            self.hideLoadingIndicator(from: self.view)
//            switch result {
//            case .success:
//
//                self.productsCollectionView.dataSource = self
//                self.productsCollectionView.delegate = self
//
//            case .failure(let error):
//                print("the error \(error)")
//                self.showErrorAlerr(title: Constants.Common.error, message: error.localizedDescription, handler: nil)
//            }
//        }

    }

    func setupUI() {
        productsCollectionView.register(ProductsBlockCollectionViewCell.nib, forCellWithReuseIdentifier: ProductsBlockCollectionViewCell.identifier)
        self.categoryNameLabel.text = viewModel?.category.name
    }

    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.totalCount
    }


    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsBlockCollectionViewCell.identifier, for: indexPath) as! ProductsBlockCollectionViewCell
        guard let viewModel = viewModel else { return cell }

        cell.configure(viewModel.product(at: indexPath), indexPath: indexPath)
        cell.delegate = self
        
//        if indexPath.row == viewModel.productsCount - 1 { // last cell
//
//            self.showLoadingIndicator(to: self.view)
//
//            viewModel.getProductsOfCategory { result in
//                self.hideLoadingIndicator(from: self.view)
//                switch result {
//                case .success:
//                    
//                    //self.productsCollectionView.reloadData()
//                    self.hideLoadingIndicator(from: self.view)
//                case .failure(let error):
//                    print("the error \(error)")
//                    self.showErrorAlerr(title: "Error".localized(), message: error.localizedDescription, handler: nil)
//                }
//
//
//            }
//
//
//        }
        
        
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        if indexPath.row == viewModel.currentCount - 4 {  //numberofitem count
            viewModel.fetchModerators()
        }
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
        guard let viewModel = viewModel else { return }
        if !viewModel.productInStock(at: indexPath) {
            showErrorAlerr(title: "Error", message: "This item is out of stock!", handler: nil)
            return
        }
        viewModel.addToCart(at: indexPath)
    }
    
    func didSelectOneClickBuy(indexPath: IndexPath) {
//        guard let viewModel = viewModel else { return }
//        viewModel.addToCart(at: indexPath)
        didSelectAddToCartCell(indexPath: indexPath)
        
        if Customer.shared.loggedin {
            let controller = UIStoryboard(name: "Cart", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewCartViewController") as! CartViewController
            controller.buyingWayType = 1
            self.navigationController?.pushViewController(controller, animated: false)
        } else {
            let controller = UIStoryboard(name: "User", bundle: Bundle.main).instantiateViewController(withIdentifier: "GuestSignUpViewcontroller") as! GuestSignUpViewcontroller
            tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(controller, animated: true)
        }
    }

}



extension CatProductsViewController: CatProductsViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        // 1
        self.hideLoadingIndicator(from: self.view)

        guard newIndexPathsToReload != nil else {
//            indicatorView.stopAnimating()
//            productsCollectionView.isHidden = false
            productsCollectionView.reloadData()
            return
        }
        // 2
//        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
//        productsCollectionView.reloadItems(at: indexPathsToReload)
//        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {
        self.hideLoadingIndicator(from: self.view)
//        indicatorView.stopAnimating()
        
//        let title = "Warning".localizedString
//        let action = UIAlertAction(title: "OK".localizedString, style: .default)
//        displayAlert(with: title , message: reason, actions: [action])
    }
}

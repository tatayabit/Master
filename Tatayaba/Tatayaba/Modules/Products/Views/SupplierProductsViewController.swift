//
//  SupplierProductsViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class SupplierProductsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProductsBlockCollectionViewCellDelegate {

    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var supplierNameLabel: UILabel!

    var viewModel: SupplierProductsViewModel?
    private let productDetailsSegue = "product_details_segue"


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
        loadData()
    }
    
    func loadData() {
        guard let viewModel = viewModel else { return }
        self.showLoadingIndicator(to: self.view)
        viewModel.getSupplierDetails { result in
            self.hideLoadingIndicator(from: self.view)
            switch result {
            case .success:
                self.productsCollectionView.dataSource = self
                self.productsCollectionView.delegate = self

            case .failure(let error):
                print("the error \(error)")
                self.showErrorAlerr(title: Constants.Common.error, message: error.localizedDescription, handler: nil)
            }
        }
    }

    func setupUI() {
        productsCollectionView.register(ProductsBlockCollectionViewCell.nib, forCellWithReuseIdentifier: ProductsBlockCollectionViewCell.identifier)
        self.supplierNameLabel.text = viewModel?.supplier.name
    }

    //MARK:- CollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.supplier.products.count
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
        guard let viewModel = viewModel else { return }
        if !viewModel.productInStock(at: indexPath) {
            showErrorAlerr(title: "Error", message: "This item is out of stock!", handler: nil)
            return
        }
        viewModel.addToCart(at: indexPath)
    }
    
    func didSelectOneClickBuy(indexPath: IndexPath) {

        guard let viewModel = viewModel else { return }
        if !viewModel.productInStock(at: indexPath) {
            showErrorAlerr(title: "Error", message: "This item is out of stock!", handler: nil)
            return
        }
        
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

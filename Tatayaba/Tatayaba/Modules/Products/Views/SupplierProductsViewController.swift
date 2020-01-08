//
//  SupplierProductsViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/16/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class SupplierProductsViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProductsBlockCollectionViewCellDelegate {

    @IBOutlet weak var filterView: SortingReusableCustomView!
    @IBOutlet weak var productsCollectionView: UICollectionView!
    @IBOutlet weak var supplierNameLabel: UILabel!

    var viewModel: SupplierProductsViewModel?
    private let productDetailsSegue = "product_details_segue"
    private let searchSegue = "search_segue"

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addSearchBtn()
        setupUI()
        self.productsCollectionView.dataSource = self
        self.productsCollectionView.delegate = self
        
        guard let viewModel = viewModel else { return }
        viewModel.setDelegate(self)
        self.filterView.delegate = self
        
        loadData()
        
    }
    
    func loadData() {
        guard let viewModel = viewModel else { return }
        self.showLoadingIndicator(to: self.view)
        viewModel.fetchModerators()
//        viewModel.getSupplierDetails { result in
//            self.hideLoadingIndicator(from: self.view)
//            switch result {
//            case .success:
//
//            case .failure(let error):
//                print("the error \(error)")
//                self.showErrorAlerr(title: Constants.Common.error, message: error.localizedDescription, handler: nil)
//            }
//        }
    }

    func setupUI() {
        NavigationBarWithBackButton()
        productsCollectionView.register(ProductsBlockCollectionViewCell.nib, forCellWithReuseIdentifier: ProductsBlockCollectionViewCell.identifier)
        self.supplierNameLabel.text = viewModel?.supplier.name
    }
    
    @objc func search() {
       performSegue(withIdentifier: searchSegue, sender: nil)
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
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let viewModel = viewModel else { return }
//        if indexPath.row == viewModel.currentCount - 1 {  //numberofitem count
//            viewModel.fetchModerators()
//            print("reached last cell!")
//        }
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
        if viewModel.productHasOptions(at: indexPath) {
            performSegue(withIdentifier: productDetailsSegue, sender: indexPath)
        } else {
            viewModel.addToCart(at: indexPath)
        }
    }
    
    func didSelectOneClickBuy(indexPath: IndexPath) {

        guard let viewModel = viewModel else { return }
        if !viewModel.productInStock(at: indexPath) {
            showErrorAlerr(title: "Error", message: "This item is out of stock!", handler: nil)
            return
        }
        
        didSelectAddToCartCell(indexPath: indexPath)
        
        if viewModel.productHasOptions(at: indexPath) { return }

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


extension SupplierProductsViewController: SupplierProductsViewModelDelegate, isAbleToReceiveData {
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        // 1
        self.hideLoadingIndicator(from: self.view)

        guard newIndexPathsToReload != nil else {
            productsCollectionView.reloadData()
            guard let viewModel = viewModel else { return }
            if viewModel.totalCount == 0 {
                showErrorAlerr(title: "", message: Constants.Products.noProductsFound) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
            }
            return
        }
        // 2
        if let newIndexPathsToReload = newIndexPathsToReload {
            productsCollectionView.insertItems(at: newIndexPathsToReload)
        }
        
        
    }
    
    func onFetchFailed(with reason: String) {
        self.hideLoadingIndicator(from: self.view)
//        indicatorView.stopAnimating()
        print("the error \(reason)")
        self.showErrorAlerr(title: Constants.Common.error, message: reason, handler: nil)
//        let title = "Warning".localizedString
//        let action = UIAlertAction(title: "OK".localizedString, style: .default)
//        displayAlert(with: title , message: reason, actions: [action])
    }
    
    
//    func onFilteringFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
//        // TODO: clear the table view before load the data
//        
//        // 1
//               self.hideLoadingIndicator(from: self.view)
//
//               guard newIndexPathsToReload != nil else {
//                   productsCollectionView.reloadData()
//                   return
//               }
//               // 2
//               if let newIndexPathsToReload = newIndexPathsToReload {
//                   productsCollectionView.insertItems(at: newIndexPathsToReload)
//               }
//               
//    }

}
extension SupplierProductsViewController : FilterDelegate{
    func freeDeliveryClick() {
        print("freeDeliveryClick")
        guard let viewModel = viewModel else { return }
        viewModel.freeDeliveryPressed()
    }
    
    func filterClick() {
        let vc = FilterTableViewController()
        vc.delegate = self
        vc.viewType = 0
        let navController = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navController, animated: true, completion: nil)
//        self.present(vc, animated: true, completion: nil)
    }
    func sortClick() {
        let vc = FilterTableViewController()
        vc.delegate = self
        vc.viewType = 1
        let navController = UINavigationController(rootViewController: vc)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
    
    func pass(data: String, type: Int) { //conforms to protocol
    // implement your own implementation
        print(data)
        guard let viewModel = viewModel else { return }
        if type == 0 {
            // filter
            viewModel.filterOptionsChanged(filterValue: data)
        } else if type == 1 {
            // sort by
            let sortBy: FilterSettings.SortingOptions = data.lowercased() == "low to high" ? .ascending : .descending
            viewModel.sortByOptionsChanged(sortBy: sortBy)
        }
        self.productsCollectionView.reloadData()
     }
    
}
protocol isAbleToReceiveData {
    func pass(data: String, type: Int)  //data: string is an example parameter, type 0 is Filter, 1 is sortBy
}

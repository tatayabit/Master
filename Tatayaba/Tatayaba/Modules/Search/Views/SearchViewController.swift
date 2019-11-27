//
//  SearchVC.swift
//  Tatayaba
//
//  Created by Mostafa Aboghida on 11/26/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, ProductsBlockCollectionViewCellDelegate {

    @IBOutlet weak var productsCollectionView: UICollectionView!

    var viewModel: CatProductsViewModel?
    private let productDetailsSegue = "search_segue"
    let searchController = UISearchController(searchResultsController: nil)
    var searchActive : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.NavigationBarWithOutBackButton()

        setupUI()
        self.productsCollectionView.dataSource = self
        self.productsCollectionView.delegate = self
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search ..."
        searchController.searchBar.sizeToFit()
        
        
        self.searchController.isActive = true
        self.navigationItem.titleView = searchController.searchBar
        
        
        
        guard let viewModel = viewModel else { return }
        self.showLoadingIndicator(to: self.view)
//        viewModel.setDelegate(self)
        viewModel.fetchModerators()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
    }
    func setupUI() {
        productsCollectionView.register(ProductsBlockCollectionViewCell.nib, forCellWithReuseIdentifier: ProductsBlockCollectionViewCell.identifier)
    }

    //MARK:- CollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        if searchActive {
            return viewModel.totalCount
        }
        else
        {
            return viewModel.totalCount
        }
        
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
        guard let viewModel = viewModel else { return }
        if indexPath.row == viewModel.currentCount - 1 {  //numberofitem count
            viewModel.fetchModerators()
            print("reached last cell!")
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: productDetailsSegue, sender: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.view.bounds.width / 2, height: 245)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionHeader) {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
            // Customize headerView here
            return headerView
        }
        fatalError()
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

extension SearchViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
      //MARK: Search Bar
    
    func didPresentSearchController(_ searchController: UISearchController) {

        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
    
      func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
          searchActive = false
          self.dismiss(animated: true, completion: nil)
          navigationController?.popViewController(animated: true)
      }
      
      func updateSearchResults(for searchController: UISearchController)
      {
          let searchString = searchController.searchBar.text
          print(searchString)
//          filtered = items.filter({ (item) -> Bool in
//              let countryText: NSString = item as NSString
//
//              return (countryText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
//          })
          
          productsCollectionView.reloadData()

      }
      
      func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(searchBar.text)
        searchActive = true
        productsCollectionView.reloadData()
      }
    
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = true
        if(!searchText.isEmpty)
            {
                //reload your data source if necessary
                print(searchText)
            }
        }
      
      
      func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
          searchActive = false
          productsCollectionView.reloadData()
      }
      
      func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
          if !searchActive {
              searchActive = true
              productsCollectionView.reloadData()
          }
          
          searchController.searchBar.resignFirstResponder()
      }
}


//
//extension SearchViewController: CatProductsViewModelDelegate {
//    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
//        // 1
//        self.hideLoadingIndicator(from: self.view)
//
//        guard newIndexPathsToReload != nil else {
//            productsCollectionView.reloadData()
//            guard let viewModel = viewModel else { return }
//            if viewModel.totalCount == 0 {
//                showErrorAlerr(title: "", message: Constants.Products.noProductsFound) { _ in
//                    self.navigationController?.popViewController(animated: true)
//                }
//            }
//            return
//        }
//        // 2
//        if let newIndexPathsToReload = newIndexPathsToReload {
//            productsCollectionView.insertItems(at: newIndexPathsToReload)
//        }
//    }
//
//    func onFetchFailed(with reason: String) {
//        self.hideLoadingIndicator(from: self.view)
////        indicatorView.stopAnimating()
//
////        let title = "Warning".localizedString
////        let action = UIAlertAction(title: "OK".localizedString, style: .default)
////        displayAlert(with: title , message: reason, actions: [action])
//    }
//}

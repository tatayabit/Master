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
    var searchViewModel = SearchProductsViewModel()
    private let productDetailsSegue = "product_details_segue"
    let searchController = UISearchController(searchResultsController: nil)
    var searchActive : Bool = false
    var searchText = ""
    var searchDelayer : Timer!

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
        searchController.searchBar.placeholder = "search Placeholder".localized()
        searchController.searchBar.sizeToFit()
        
        self.searchController.isActive = true
        
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
            self.navigationItem.titleView = searchController.searchBar
        }
//        searchController.searchBar.tintColor = .white
        searchController.searchBar.backgroundColor = .brandDarkBlue
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.brandDarkBlue]
        
        let searchFieldBackgroundImage = UIImage(color: .white, size: CGSize(width: 44, height: searchController.searchBar.bounds.height/3.9))?.withRoundCorners(4)
        UISearchBar.appearance().setSearchFieldBackgroundImage(searchFieldBackgroundImage, for: .normal)
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Cancel".localized()
        searchViewModel.setDelegate(self)
        }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchController.isActive = true
    }
    func setupUI() {
        productsCollectionView.register(ProductsBlockCollectionViewCell.nib, forCellWithReuseIdentifier: ProductsBlockCollectionViewCell.identifier)
    }

    //MARK:- CollectionViewDelegate
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return searchViewModel.productsList.count
       }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductsBlockCollectionViewCell.identifier, for: indexPath) as! ProductsBlockCollectionViewCell
        cell.configure(searchViewModel.productsList[indexPath.row], indexPath: indexPath)
        cell.delegate = self
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == searchViewModel.currentCount - 1 {  //numberofitem count
            if(!searchText.isEmpty){
                searchViewModel.fetchModerators(keyword: searchText)
            }
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
//        guard let viewModel = viewModel else { return }
        if !searchViewModel.productInStock(at: indexPath) {
            showErrorAlerr(title: "Error", message: "This item is out of stock!", handler: nil)
            return
        }
        if searchViewModel.productHasOptions(at: indexPath) {
            performSegue(withIdentifier: productDetailsSegue, sender: indexPath)
        } else {
            searchViewModel.addToCart(at: indexPath)
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.searchController.searchBar.endEditing(true)
    }
    
    
    //MARK:- Segue
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == productDetailsSegue {
             let productDetailsVC = segue.destination as! ProductDetailsViewController
             if let indexPath = sender as? IndexPath {
                productDetailsVC.viewModel = ProductDetailsViewModel(product: searchViewModel.productsList[indexPath.row])
             }
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
          navigationController?.popViewController(animated: true)
      }
      
      func updateSearchResults(for searchController: UISearchController)
      {
          let searchString = searchController.searchBar.text
          print(searchString)
          productsCollectionView.reloadData()
      }
      
      func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print(searchBar.text)
        searchActive = true
        productsCollectionView.reloadData()
      }
    
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = true
        searchViewModel.productsList.removeAll()
        searchViewModel.currentPage = 0
//        searchDelayer = nil
        if (searchDelayer == nil) {
            searchDelayer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.doDelayedSearch), userInfo: searchText, repeats: false)
        }else{
            searchDelayer.invalidate()
            searchDelayer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.doDelayedSearch), userInfo: searchText, repeats: false)
        }
        }
      
    @objc func doDelayedSearch (_ t: Timer){
        assert(t == searchDelayer)
        let searchText = searchDelayer.userInfo! as! String
        if(!searchText.isEmpty)
            {
                self.searchText = searchText
                //reload your data source if necessary
                self.showLoadingIndicator(to: self.view)
                searchViewModel.fetchModerators(keyword: searchText)
                print(searchText)
        }else{
            self.productsCollectionView.reloadData()
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



extension SearchViewController: SearchProductsViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        // 1
        self.hideLoadingIndicator(from: self.view)
        
        guard newIndexPathsToReload != nil else {
            productsCollectionView.reloadData()
            if searchViewModel.totalCount == 0 {
//                showErrorAlerr(title: "", message: Constants.Products.noProductsFound) { _ in
//                    self.navigationController?.popViewController(animated: true)
//                }
            }
            return
        }
        // 2
        if let newIndexPathsToReload = newIndexPathsToReload {
            if newIndexPathsToReload.count == 0 {
                productsCollectionView.reloadData()
            }
            productsCollectionView.insertItems(at: newIndexPathsToReload)
        }
    }

    func onFetchFailed(with reason: String) {
        self.hideLoadingIndicator(from: self.view)
//        indicatorView.stopAnimating()

//        let title = "Warning".localizedString
//        let action = UIAlertAction(title: "OK".localizedString, style: .default)
//        displayAlert(with: title , message: reason, actions: [action])
    }
}

public extension UIImage {

    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }

    public func withRoundCorners(_ cornerRadius: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)

        context?.beginPath()
        context?.addPath(path.cgPath)
        context?.closePath()
        context?.clip()

        draw(at: CGPoint.zero)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();

        return image;
    }

}

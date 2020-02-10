//
//  SuppliersListViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class SuppliersListViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CountrySettingsDelegate {

    @IBOutlet weak var supplierCollection_View: UICollectionView!
//    lazy var searchBar:UISearchBar = UISearchBar()
    let viewModel = SuppliersListViewModel()
    
    private let supplierProductsSegue = "supplier_products_segue"
    private let searchSegue = "search_segue"
    private let filterSegue = "filter_segue"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        addSearchBtn()
        CountrySettings.shared.addDelegate(delegate: self)
        viewModel.setDelegate(self)
//        viewModel.onsuppliersListLoad = {
//            self.supplierCollection_View.reloadData()
//        }
        reloadData()
    }

    func setupUI() {
        NavigationBarWithBackButton()
        supplierCollection_View.register(SuppliersCollectionViewCell.nib, forCellWithReuseIdentifier: SuppliersCollectionViewCell.identifier)
//        setupSearchButton()
            
    }
    
    func countryDidChange(to country: Country) {
        print("country changes!!!")
        print("SuppliersListViewController")
        reloadData()
    }
    
    func reloadData() {
        viewModel.reset()
    }

    
    // MARK:- SetupSearch Button
//    fileprivate func setupSearchButton() {
//        self.addSearchBarButton()
//        searchBar.isHidden = true
//        searchBar.searchBarStyle = UISearchBar.Style.prominent
//        searchBar.placeholder = " Search..."
//        searchBar.sizeToFit()
//        searchBar.delegate = self
//        searchBar.isTranslucent = false
//        searchBar.backgroundImage = UIImage()
//        searchBar.showsCancelButton = true
//        let cancelButtonAttributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue): UIColor.white]
//        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(cancelButtonAttributes, for: .normal)
//
//        navigationItem.titleView = searchBar
//    }
    
//     func addSearchBarButton() {
//        let button = UIButton(frame: CGRect(x:UIScreen.main.bounds.width-40 , y: 0, width: 20, height: 20))
//        button.setBackgroundImage(UIImage(named: "Search"), for: .normal)
//        button.addTarget(self, action: #selector(self.SearchButtonAction), for: .touchUpInside)
//
//        let barbutton = UIBarButtonItem(customView: button)
//        self.navigationItem.rightBarButtonItem = barbutton
//    }
    
    
//    @objc func SearchButtonAction(){
//        
//        searchBar.isHidden =  false
//        searchBar.alpha = 0
//        navigationItem.titleView = searchBar
//        navigationItem.setLeftBarButton(nil, animated: true)
//        navigationItem.setRightBarButton(nil, animated: true)
//        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.searchBar.alpha = 1
//        }, completion: { finished in
//            self.searchBar.becomeFirstResponder()
//        })
//        
//    }
    
    @objc func search() {
       performSegue(withIdentifier: searchSegue, sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SuppliersCollectionViewCell.identifier, for: indexPath) as! SuppliersCollectionViewCell
            cell.configure(supplier: viewModel.supplier(at: indexPath))
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == viewModel.currentCount - 12 {  //numberofitem count
            viewModel.fetchModerators()
            print("reached last cell!")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: supplierProductsSegue, sender: indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.bounds.width - 14) / 3, height: 150)
    }
    func filter() {
       performSegue(withIdentifier: filterSegue, sender: nil)
    }


    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == supplierProductsSegue {
            let productsListVC = segue.destination as! SupplierProductsViewController
            if let indexPath = sender as? IndexPath {
                productsListVC.viewModel = viewModel.supplierProductsViewModel(indexPath: indexPath)
            }
        }
    }
}


extension SuppliersListViewController: SuppliersListViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        // 1
        self.hideLoadingIndicator(from: self.view)

        guard newIndexPathsToReload != nil else {
            self.supplierCollection_View.reloadData()
            if viewModel.totalCount == 0 {
                showErrorAlerr(title: "", message: Constants.Products.noProductsFound) { _ in
                    self.navigationController?.popViewController(animated: true)
                }
            }
            return
        }
        // 2
        if let newIndexPathsToReload = newIndexPathsToReload {
            self.supplierCollection_View.insertItems(at: newIndexPathsToReload)
        }
    }
    
    func onFetchFailed(with reason: String) {
        self.hideLoadingIndicator(from: self.view)
        self.supplierCollection_View.reloadData()
    }
    
    
}

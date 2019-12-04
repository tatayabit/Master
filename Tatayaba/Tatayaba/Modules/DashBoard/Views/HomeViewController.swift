//
//  HomeViewController.swift
//  Tatayaba
//
//  Created by Admin on 03/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: BaseViewController, BannersBlocksViewProtocol, CategoriesBlockViewProtocol, ProductsBlockViewProtocol, SuppliersBlockViewProtocol, FullScreenBannersViewProtocol, CountrySettingsDelegate, CurrencySettingsDelegate {
    

    
    func currencyDidChange(to currency: Currency) {
        print("currency changes!!!")
        print("HomeViewController")
    }
   
    private let productDetailsSegue = "product_details_segue"
    private let categoryProductsSegue = "category_products_segue"
    private let supplierProductsSegue = "supplier_products_segue"
    private let allCategoriesSegue = "all_categories_segue"
    private let allSuppliersSegue = "all_supplier_segue"
    private let searchSegue = "search_segue"
    

    
    
    @IBOutlet weak var scrollView: StackedScrollView!
    var tabbar:UITabBar?
    private var viewModel = HomeViewModel()

    let squaredBlockView: BannersBlocksView = .fromNib()
    let productsBlocklView: ProductsBlockView = .fromNib()//[UIView?]
    let fullScreenBannersView: FullScreenBannersView = .fromNib()
    let categoriesBlockView: CategoriesBlockView = .fromNib()
    let suppliersBlockView: SuppliersBlockView = .fromNib()

//    // Duplicated Products (Will be removed  later)
//    let productsBlocklViewCopyX: ProductsBlockView = .fromNib()
//    let productsBlocklViewCopyXX: ProductsBlockView = .fromNib()
//
    
    
    // Duplicated Products (Will be updated  later)
    let productsBlocklView270: ProductsBlockView = .fromNib()
    let productsBlocklView305: ProductsBlockView = .fromNib()
    let productsBlocklView267: ProductsBlockView = .fromNib()
    let productsBlocklView297: ProductsBlockView = .fromNib()
    let productsBlocklView248: ProductsBlockView = .fromNib()
    let productsBlocklView265: ProductsBlockView = .fromNib()
    
    let locationManager = LocationManager()
    
    
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addBannersSubView()
        setupListners()
        setupUI()
        addSearchBtn()
        viewModel.loadAPIs()
        let cart = Cart.shared
        cart.updateTabBarCount()
        CountriesManager.shared.loadCountriesList()
        CurrenciesManager.shared.loadCurrenciesList()
        CountrySettings.shared.addDelegate(delegate: self)
        CurrencySettings.shared.addCurrencyDelegate(delegate: self)
        locationManager.delegate = self
        locationManager.initService()
    }

    fileprivate func addBannersSubView() {
        fullScreenBannersView.delegate = self
        scrollView.stackView.addArrangedSubview(fullScreenBannersView)
        fullScreenBannersView.translatesAutoresizingMaskIntoConstraints = false
        fullScreenBannersView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        self.showLoadingIndicator(to: fullScreenBannersView)
      

        categoriesBlockView.delegate = self
        scrollView.stackView.addArrangedSubview(categoriesBlockView)
        categoriesBlockView.translatesAutoresizingMaskIntoConstraints = false
        categoriesBlockView.heightAnchor.constraint(equalToConstant: 115).isActive = true
        self.showLoadingIndicator(to: categoriesBlockView)


        squaredBlockView.delegate = self
        scrollView.stackView.addArrangedSubview(squaredBlockView)
        squaredBlockView.translatesAutoresizingMaskIntoConstraints = false
        squaredBlockView.heightAnchor.constraint(equalToConstant: 225).isActive = true
        //
        
        //
        self.showLoadingIndicator(to: squaredBlockView)


        productsBlocklView.delegate = self
        scrollView.stackView.addArrangedSubview(productsBlocklView)
        productsBlocklView.translatesAutoresizingMaskIntoConstraints = false
        productsBlocklView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        self.showLoadingIndicator(to: productsBlocklView)

        
        self.addDupplicatedProducts()

        suppliersBlockView.delegate = self
        scrollView.stackView.addArrangedSubview(suppliersBlockView)
        suppliersBlockView.translatesAutoresizingMaskIntoConstraints = false
        suppliersBlockView.heightAnchor.constraint(equalToConstant: 165).isActive = true
        self.showLoadingIndicator(to: suppliersBlockView)
        
        

    }

    fileprivate func loadSquaredBlockViewData() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
//                           completion()
//                       })
        DispatchQueue.main.async {
            self.hideLoadingIndicator(from: self.squaredBlockView)
            self.squaredBlockView.block = self.viewModel.squareBlock
            self.squaredBlockView.loadData()
    //        squaredBlockView.titleLabel.text = "Trending on Tatayab"
            self.squaredBlockView.viewAllButton.isHidden = true
        }
    }


    fileprivate func loadProductsBlockViewData() {
        DispatchQueue.main.async {

        self.hideLoadingIndicator(from: self.productsBlocklView)
        self.productsBlocklView.block = self.viewModel.productsBlocks[0]
        self.productsBlocklView.loadData()
        
        self.hideLoadingIndicator(from: self.productsBlocklView270)
        self.productsBlocklView270.block = self.viewModel.productsBlocks[1]
        self.productsBlocklView270.loadData()
        
        self.hideLoadingIndicator(from: self.productsBlocklView305)
        self.productsBlocklView305.block = self.viewModel.productsBlocks[2]
        self.productsBlocklView305.loadData()
        
        self.hideLoadingIndicator(from: self.productsBlocklView267)
        self.productsBlocklView267.block = self.viewModel.productsBlocks[3]
        self.productsBlocklView267.loadData()
        
        self.hideLoadingIndicator(from: self.productsBlocklView297)
        self.productsBlocklView297.block = self.viewModel.productsBlocks[4]
        self.productsBlocklView297.loadData()
        
        self.hideLoadingIndicator(from: self.productsBlocklView248)
        self.productsBlocklView248.block = self.viewModel.productsBlocks[5]
        self.productsBlocklView248.loadData()
        
        self.hideLoadingIndicator(from: self.productsBlocklView265)
        self.productsBlocklView265.block = self.viewModel.productsBlocks[6]
        self.productsBlocklView265.loadData()
//
//        // Will be removed later
//        self.hideLoadingIndicator(from: productsBlocklViewCopyX)
//        productsBlocklViewCopyX.block = viewModel.productsBlock
//        productsBlocklViewCopyX.loadData()
//
//        self.hideLoadingIndicator(from: productsBlocklViewCopyXX)
//        productsBlocklViewCopyXX.block = viewModel.productsBlock
//        productsBlocklViewCopyXX.loadData()
        
        }
    }

    fileprivate func loadFullScreenBannersViewData() {
        DispatchQueue.main.async {
            self.hideLoadingIndicator(from: self.fullScreenBannersView)
            self.fullScreenBannersView.block = self.viewModel.topBannersBlock
            self.fullScreenBannersView.loadData()
        }
    }

    fileprivate func loadCategoriesBlockViewData() {
        DispatchQueue.main.async {

            self.hideLoadingIndicator(from: self.categoriesBlockView)
            self.categoriesBlockView.categories = self.viewModel.categoriesList
            self.categoriesBlockView.loadData()
        }
    }

    fileprivate func loadSuppliersBlockViewData() {
        DispatchQueue.main.async {

            self.hideLoadingIndicator(from: self.suppliersBlockView)

            self.suppliersBlockView.suppliers = self.viewModel.suppliersList
            self.suppliersBlockView.loadData()
        }
    }


    func setupListners() {
        viewModel.onCategoriesListLoad = {
            self.loadCategoriesBlockViewData()
        }

        viewModel.onSquareBlockLoad = {
            self.loadSquaredBlockViewData()
        }

        viewModel.onTopBannersBlockLoad = {
            self.loadFullScreenBannersViewData()
        }

        viewModel.onSuppliersBlockLoad = {
            self.loadSuppliersBlockViewData()
        }

        viewModel.onProductsBlockLoad = {
            self.loadProductsBlockViewData()
        }
    }
    
    // MARK:- Duplicated Products (Will be removed later)
    func addDupplicatedProducts() {
        productsBlocklView270.delegate = self
        scrollView.stackView.addArrangedSubview(productsBlocklView270)
        productsBlocklView270.translatesAutoresizingMaskIntoConstraints = false
        productsBlocklView270.heightAnchor.constraint(equalToConstant: 260).isActive = true
        productsBlocklView270.titleLabel.text = "PERSONAL CARE".localized()
        self.showLoadingIndicator(to: productsBlocklView270)
        
        productsBlocklView305.delegate = self
        scrollView.stackView.addArrangedSubview(productsBlocklView305)
        productsBlocklView305.translatesAutoresizingMaskIntoConstraints = false
        productsBlocklView305.heightAnchor.constraint(equalToConstant: 260).isActive = true
        productsBlocklView305.titleLabel.text = ""
        self.showLoadingIndicator(to: productsBlocklView305)
        
        productsBlocklView267.delegate = self
        scrollView.stackView.addArrangedSubview(productsBlocklView267)
        productsBlocklView267.translatesAutoresizingMaskIntoConstraints = false
        productsBlocklView267.heightAnchor.constraint(equalToConstant: 260).isActive = true
        productsBlocklView267.titleLabel.text = ""
        self.showLoadingIndicator(to: productsBlocklView267)
        
        productsBlocklView297.delegate = self
        scrollView.stackView.addArrangedSubview(productsBlocklView297)
        productsBlocklView297.translatesAutoresizingMaskIntoConstraints = false
        productsBlocklView297.heightAnchor.constraint(equalToConstant: 260).isActive = true
        productsBlocklView297.titleLabel.text = ""
        self.showLoadingIndicator(to: productsBlocklView297)
        
        productsBlocklView248.delegate = self
        scrollView.stackView.addArrangedSubview(productsBlocklView248)
        productsBlocklView248.translatesAutoresizingMaskIntoConstraints = false
        productsBlocklView248.heightAnchor.constraint(equalToConstant: 260).isActive = true
        productsBlocklView248.titleLabel.text = ""
        self.showLoadingIndicator(to: productsBlocklView248)
        
        productsBlocklView265.delegate = self
        scrollView.stackView.addArrangedSubview(productsBlocklView265)
        productsBlocklView265.translatesAutoresizingMaskIntoConstraints = false
        productsBlocklView265.heightAnchor.constraint(equalToConstant: 260).isActive = true
        productsBlocklView265.titleLabel.text = ""
        self.showLoadingIndicator(to: productsBlocklView265)
        
    }

    // MARK:- SetupUI
    func setupUI() {
        self.scrollView.stackView.spacing = 0
       self.scrollView.stackView.backgroundColor = UIColor(hexString: "F3F3F3")
        self.scrollView.backgroundColor = UIColor(hexString: "F3F3F3")

        self.NavigationBarWithOutBackButton()
        self.tabbar?.selectedItem = tabbar?.items?[0]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated) // No need for semicolon
        self.tabBarController?.tabBar.isHidden = false
        ValidateVersionVersion()
        
    }

    // MARK:- CategoriesBlockView delegate
    func didSelectCategory(at indexPath: IndexPath) {
        performSegue(withIdentifier: categoryProductsSegue, sender: indexPath)
    }
    
    func didSelectBannerBlocks(at indexPath: IndexPath) {
        let result = viewModel.parseSquareBlockDeeplink(at: indexPath)
        if result.type == .category {
            performSegue(withIdentifier: categoryProductsSegue, sender: result)
        }
    }
    
    // MARK:- SuppliersBlockViewProtocol delegate
    func didSelectFullScreenBanner(at indexPath: IndexPath) {
        let result = viewModel.parsetopBannersBlockDeeplink(at: indexPath)
        if result.type == .category {
            performSegue(withIdentifier: categoryProductsSegue, sender: result)
        }
    }

    //MARK:- ProductsBlockViewProtocol
    func didSelectProduct(at indexPath: IndexPath, block_Id : String) {
        print(block_Id)
        self.viewModel.block_Id = block_Id
        performSegue(withIdentifier: productDetailsSegue, sender: indexPath)
    }

    func didAddToCart(product: Product) {
        // addProdcut to cart
        if !product.isInStock {
            showErrorAlerr(title: "Error", message: "This item is out of stock!", handler: nil)
            return
        }
        viewModel.addToCart(product: product)
    }
    
    func didSelectOneClick(product: Product) {
        didAddToCart(product: product)
        
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

    //MARK:- SuppliersBlockViewProtocol
    func didSelectSupplier(at indexPath: IndexPath) {
        performSegue(withIdentifier: supplierProductsSegue, sender: indexPath)
    }
    
    func didSelectViewAllSuppliers() {
        performSegue(withIdentifier: allSuppliersSegue, sender: nil)
    }
    
    // MARK:- CountrySettingsDelegate
    func countryDidChange(to country: Country) {
        print("country changes!!!")
        print("HomeViewController")
    }
    
    
    func ValidateVersionVersion(){
        viewModel.ValidateVersionVersion(){ status in
            if(status != "success"){
                self.showAlert()
            }
            
            }
    }
    func showAlert()
    {
        let alert = UIAlertController(title: "Alert", message: "alertValaidationMessage".localized(), preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
              switch action.style{
              case .default:
                self.viewModel.openStoreURL()
                self.showAlert()
              case .cancel:
                    print("cancel")

              case .destructive:
                    print("destructive")


        }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func search() {
       performSegue(withIdentifier: searchSegue, sender: nil)
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

        if segue.identifier == categoryProductsSegue {
            let productsListVC = segue.destination as! CatProductsViewController
            if let indexPath = sender as? IndexPath {
                productsListVC.viewModel = viewModel.catProductsListViewModel(indexPath: indexPath)
            }
            
            if let deeplink = sender as? DeepLinkModel {
                productsListVC.viewModel = viewModel.catProductsListViewModel(with: deeplink.id, title: deeplink.title)
            }
        }

        if segue.identifier == supplierProductsSegue {
            let productsListVC = segue.destination as! SupplierProductsViewController
            if let indexPath = sender as? IndexPath {
                productsListVC.viewModel = viewModel.supplierProductsViewModel(indexPath: indexPath)
            }
        }
    }
}

extension HomeViewController: LocationManagerDelegate {
    func didDetectCurrentUserLocation(location: CLLocation) {
        print("current user location: \(location)")
    }
    
    func userLocationDenied() {
        // initialise a pop up for using later
        let alertController = UIAlertController(title: "Location Service is disabled", message: "Please go to Settings and turn on the permissions", preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
             }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}


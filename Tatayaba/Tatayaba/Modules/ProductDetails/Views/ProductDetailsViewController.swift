//
//  ProductDetailsViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/17/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProductDetailsViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, AlsoBoughtProductsTableViewCellDelegate {
    
    @IBOutlet weak var product_Tableview: UITableView!
    
    enum sectionType: Int {
        case details = 0, options
    }
    
    var viewModel: ProductDetailsViewModel?
    var headerItems = [HeaderItem]()
    var reloadSections: ((_ section: Int) -> Void)?
    
    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.NavigationBarWithBackButton()
        setupUI()
        callAlsoBoughtProductsApi()
    }
    
    func setupUI() {
        product_Tableview.register(OptionCollectionViewCell.nib, forCellReuseIdentifier: OptionCollectionViewCell.identifier)
        product_Tableview.register(AlsoBoughtProductsTableViewCell.nib, forCellReuseIdentifier: AlsoBoughtProductsTableViewCell.identifier)
        product_Tableview.register(OptionsHeader.nib, forHeaderFooterViewReuseIdentifier: OptionsHeader.identifier)
        
    }
    
    // MARK:- Load sections
    func initSections() {
        guard let viewModel = viewModel else { return }
        let item = HeaderItem(rowCount: 1, collapsed: true, isCollapsible: false)
        headerItems.append(item)

        if viewModel.optionsCount > 0 {
            for i in 1..<(viewModel.optionsCount + 1) {
                let numberOfRows = viewModel.numberOfVariants(at: i)
                let item = HeaderItem(rowCount: numberOfRows, collapsed: true, isCollapsible: numberOfRows > 0)
                headerItems.append(item)
            }
            
            
            reloadSections = { section in
                let indexSet = IndexSet(integer: section)
                self.product_Tableview.reloadSections(indexSet, with: .automatic)
            }
        }
        if viewModel.numberOfAlsoBoughtProducts > 0 {
            let item = HeaderItem(rowCount: 0, collapsed: true, isCollapsible: false)
            headerItems.append(item)
        }
        product_Tableview.delegate = self
        product_Tableview.dataSource = self
        product_Tableview.reloadData()
    }
    
    // MARK:- Api
    func callDetailsApi() {
//        product_Tableview.delegate = self
//        product_Tableview.dataSource = self
        
        self.showLoadingIndicator(to: self.view)
        self.viewModel?.getProductDetails(completion: { result in
            self.hideLoadingIndicator(from: self.view)
            switch result {
                
            case .success:
                self.initSections()
//                self.product_Tableview.reloadData()
                
            case .failure(let error):
                print("the error \(error)")
                self.showErrorAlerr(title: "Error", message: "not able to fetch the product", handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                })
            }
        })
    }
    
    func callAlsoBoughtProductsApi() {
        guard let viewModel = viewModel else { return }
        viewModel.getAlsoBoughtProducts(completion: { result in

            switch result {
                
            case .success:
//                self.initSections()
//                self.product_Tableview.reloadData()
                print("success")
                self.callDetailsApi()
            case .failure(let error):
                print("the error \(error)")
                self.showErrorAlerr(title: "Error", message: "not able to fetch the also bought products", handler: nil)
            }
        })
    }

    //MARK:- IBActions
    @IBAction func Add_Cart(_ sender: Any) {
        addToCartAction()
        let controller = UIStoryboard(name: "Cart", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewCartViewController") as! CartViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @IBAction func oneClickBuyBtnClicked(_ sender: Any) {
        guard let viewModel = viewModel else { return }
        if !viewModel.inStock {
            showErrorAlerr(title: "Error", message: "This item is out of stock!", handler: nil)
            return
        }
        
        viewModel.addToCart()
        if Customer.shared.loggedin {
            let controller = UIStoryboard(name: "Cart", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewCartViewController") as! CartViewController
            controller.buyingWayType = 0
            self.navigationController?.pushViewController(controller, animated: false)
        } else {
            let controller = UIStoryboard(name: "User", bundle: Bundle.main).instantiateViewController(withIdentifier: "GuestSignUpViewcontroller") as! GuestSignUpViewcontroller
            tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func addToCartAction() {
        guard let viewModel = viewModel else { return }
        if !viewModel.inStock {
            showErrorAlerr(title: "Error", message: "This item is out of stock!", handler: nil)
            return
        }
        
        if viewModel.hasRequiredOptions {
            if viewModel.isAllRequiredOptionsSelected() {
                viewModel.addToCart()
            } else {
                showErrorAlerr(title: "Error", message: "please choose the required options.", handler: nil)
            }
        } else {
            viewModel.addToCart()
        }
    }

}
extension ProductDetailsViewController: OptionsHeaderDelegate, ProductDeatailsTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let viewModel = viewModel {
            if viewModel.isAlsoBoughtSection(section: section) {
                return 1
            }
        }
        
        switch section {
        case sectionType.details.rawValue:
            return 1
        default:
            // need to check if section oppened or no
                let item = headerItems[section]
                guard item.isCollapsible else {
                    return item.rowCount
                }
                
                if !item.collapsed {
                    return item.rowCount
                }
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let viewModel = viewModel {
            if viewModel.isAlsoBoughtSection(section: indexPath.section) {
                return 260
            }
        }
        
        switch indexPath.section {
        case sectionType.details.rawValue:
            return UITableView.automaticDimension
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let viewModel = viewModel {
            if viewModel.isAlsoBoughtSection(section: indexPath.section) {
                let cell = tableView.dequeueReusableCell(withIdentifier: AlsoBoughtProductsTableViewCell.identifier, for: indexPath) as! AlsoBoughtProductsTableViewCell
                cell.configure(with: viewModel.alsoBoughtProductsBlock)
                cell.delegate = self
                return cell
            }
        }
        
        switch indexPath.section {
        case sectionType.details.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductDeatailsTableViewCell.identifier, for: indexPath) as! ProductDeatailsTableViewCell
            cell.viewController = self
            if let viewModel = viewModel {
                cell.configure(productVM: viewModel.detailsCellVM())
            }
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: OptionCollectionViewCell.identifier, for: indexPath) as! OptionCollectionViewCell
            if let viewModel = viewModel {
                cell.configure(option: viewModel.optionVariant(at: indexPath), selected: viewModel.selected(at: indexPath))
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case sectionType.details.rawValue: break
        default:
            tableView.deselectRow(at: indexPath, animated: true)
            guard let viewModel = viewModel else { return }
            viewModel.didSelectOption(at: indexPath)
            product_Tableview.reloadData()
        }
    }
    
    // MARK:- Header
    
    func numberOfSections(in tableView: UITableView) -> Int {
//           guard let viewModel = viewModel else { return 1 }
        return headerItems.count//viewModel.numberOfSections
       }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let viewModel = viewModel {
            if viewModel.isAlsoBoughtSection(section: section) {
                return 0
            }
        }
        
        switch section {
        case sectionType.details.rawValue:
            return 0
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: OptionsHeader.identifier) as? OptionsHeader {
            if section > 0 {
                let item = headerItems[section]
                guard let viewModel = viewModel else { return UIView() }
                let option = viewModel.optionHeader(at: section)
                let required = option.required == "Y"
                headerView.configure(titleObj: option.name, itemObj: item, sectionObj: section, required: required)
                headerView.delegate = self
                return headerView
            }
        }
        
        return UIView()
    }
    
    func toggleSection(header: OptionsHeader, section: Int) {
        let item = headerItems[section]
        if item.isCollapsible {
            
            // Toggle collapse
            let collapsed = !item.collapsed
            item.collapsed = collapsed
//            header.setCollapsed(collapsed: collapsed)
            headerItems[section] = item
            // Adjust the number of the rows inside the section
            if let block = reloadSections {
                block(section)
                if !collapsed {
                    product_Tableview.scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: true)
                }
            }
        }
    }
    
    // MARK:- Footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    // MARK:- ProductDeatailsTableViewCellDelegate
    func didIncreaseQuantity() {
        guard let viewModel = viewModel else { return }
        viewModel.increase()
    }
      
    func didDecreaseQuantity() {
        guard let viewModel = viewModel else { return }
        viewModel.decrease()
    }
    
    //MARK:- AlsoBoughtProductsTableViewCellDelegate
       func didSelectProduct(at indexPath: IndexPath) {
//           performSegue(withIdentifier: productDetailsSegue, sender: indexPath)
        guard let storyboard = self.storyboard else { return }
        let controller = storyboard.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
        controller.viewModel = viewModel?.alsoBoughtProductDetailsViewModel(at: indexPath)
        self.navigationController?.pushViewController(controller, animated: false)
       }

       func didAddToCart(product: Product) {
           // addProdcut to cart
        if !product.isInStock {
            showErrorAlerr(title: "Error", message: "This item is out of stock!", handler: nil)
            return
        }
        guard let viewModel = viewModel else { return }
        viewModel.addToCartAlsoBoughtProduct(product: product)
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
}

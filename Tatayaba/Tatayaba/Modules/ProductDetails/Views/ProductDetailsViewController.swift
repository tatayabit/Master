//
//  ProductDetailsViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/17/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class ProductDetailsViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

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
        callDetailsApi()
    }
    
    func setupUI() {
        product_Tableview.register(OptionCollectionViewCell.nib, forCellReuseIdentifier: OptionCollectionViewCell.identifier)
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
    }
    
    // MARK:- Api
    func callDetailsApi() {
        product_Tableview.delegate = self
        product_Tableview.dataSource = self
        
        self.showLoadingIndicator(to: self.view)
        self.viewModel?.getProductDetails(completion: { result in
            self.hideLoadingIndicator(from: self.view)
            switch result {
                
            case .success:
                self.initSections()
                self.product_Tableview.reloadData()
                
            case .failure(let error):
                print("the error \(error)")
                self.showErrorAlerr(title: "Error", message: "not able to fetch the product", handler: { _ in
                    self.navigationController?.popViewController(animated: true)
                })
            }
        })
    }

    @IBAction func Add_Cart(_ sender: Any) {
        addToCartAction()
        let controller = UIStoryboard(name: "Cart", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewCartViewController") as! NewCartViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    @IBAction func oneClickBuyBtnClicked(_ sender: Any) {
        if Customer.shared.loggedin {
            let controller = UIStoryboard(name: "Cart", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewCartViewController") as! NewCartViewController
            controller.buyingWayType = 0
            self.navigationController?.pushViewController(controller, animated: false)
        } else {
            let controller = UIStoryboard(name: "User", bundle: Bundle.main).instantiateViewController(withIdentifier: "GuestSignUpViewcontroller") as! GuestSignUpViewcontroller
            tabBarController?.tabBar.isHidden = true
            navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    //MARK:- IBActions
    func addToCartAction() {
        guard let viewModel = viewModel else { return }
        viewModel.addToCart()
    }

}
extension ProductDetailsViewController: OptionsHeaderDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 1 }
        return viewModel.optionsCount + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case sectionType.details.rawValue:
            return 1
        default:
            // need to check if section oppened or no
//            if headerItems.count > 0 {
                let item = headerItems[section]
                guard item.isCollapsible else {
                    return item.rowCount
                }
                
                if !item.collapsed {
                    return item.rowCount
                }
//            }
            
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case sectionType.details.rawValue:
            return 407
        default:
            return 60
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case sectionType.details.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductDeatailsTableViewCell.identifier, for: indexPath) as! ProductDeatailsTableViewCell
            if let viewModel = viewModel {
                cell.configure(viewModel: viewModel.detailsCellVM())
            }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: OptionCollectionViewCell.identifier) as! OptionCollectionViewCell
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
            let cell = tableView.cellForRow(at: indexPath) as! OptionCollectionViewCell
            cell.updateRemoveButton(hide: !viewModel.selected(at: indexPath))
            
//            product_Tableview.reloadData()
        }
    }
    
    // MARK:- Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
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
                headerView.configure(titleObj: viewModel.optionHeader(at: section).name, itemObj: item, sectionObj: section)
                headerView.backgroundColor = .white
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
}

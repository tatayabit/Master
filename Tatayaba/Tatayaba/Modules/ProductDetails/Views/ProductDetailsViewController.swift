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
    let productDetailsView: ProductDetailsView = .fromNib()
    let productOptionsView: ProductOptionsView = .fromNib()
    let SelectOptionProductView: SelectOptionProduct = .fromNib()
    
    enum sectionType: Int {
        case details = 0, options
    }
    
    var viewModel: ProductDetailsViewModel?

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
    }
    
    func callDetailsApi() {
        product_Tableview.delegate = self
        product_Tableview.dataSource = self
        
        self.showLoadingIndicator(to: self.view)
        self.viewModel?.getProductDetails(completion: { result in
            self.hideLoadingIndicator(from: self.view)
            switch result {
                
            case .success:
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
extension ProductDetailsViewController{
    
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
            return 1
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case sectionType.details.rawValue:
            return 407
        default:
            return 60
        }
        
//        if indexPath.section == 0{
//               return 407
//        }
//        if indexPath.section == 1{
//            return 60
//        }
//        if indexPath.section == 2{
//              return 200
//
//        }else{
//            return 0
//        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case sectionType.details.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: productDeatailsTableViewCell.identifier, for: indexPath) as! productDeatailsTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: OptionCollectionViewCell.identifier) as! OptionCollectionViewCell
//            cell.configure(option: <#T##ProductOption#>)
            return cell
        }
//        if  indexPath.section == 0 {
//
//            self.productDetailsView.viewModel = viewModel
//            self.productDetailsView.loadData()
//            cell.addSubview(self.productDetailsView)
//
//        }
//        if  indexPath.section == 1 {
//                if indexPath.row == 0{
//                    productOptionsView.viewModel = viewModel
//                    cell.addSubview(productOptionsView)
//                }else {
//                      let SelectOptionProductView: SelectOptionProduct = .fromNib()
//                      cell.addSubview(SelectOptionProductView)
//                }
//            }
//        if  indexPath.section == 2
//            {
//                
//            }
  
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
          product_Tableview.reloadData()
    }
    
  
}

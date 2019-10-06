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
    @IBOutlet weak var scrollView: StackedScrollView!
    let productDetailsView: ProductDetailsView = .fromNib()
    let productOptionsView: ProductOptionsView = .fromNib()
    let SelectOptionProductView: SelectOptionProduct = .fromNib()
    
    var priceButton: UIButton = UIButton(type: .custom)
    var productOptionCellNUmber:Int = 1
    var viewModel: ProductDetailsViewModel?

    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       // addSubViews()
         self.NavigationBarWithBackButton()
         UserDefaults.standard.set("0", forKey: "Clicked")
        product_Tableview.delegate = self
        product_Tableview.dataSource = self
    }

    //MARK:- Setup StackedScrollView
    func addSubViews() {
        scrollView.backgroundColor = UIColor(hexString: "#E9EBEC")
        scrollView.stackView.backgroundColor = UIColor(hexString: "#E9EBEC")
        setupProductDetailsView()
        setupOptionsView()
       // setupPriceButton()
    }



    fileprivate func setupProductDetailsView() {
        productDetailsView.viewModel = viewModel
        productDetailsView.loadData()
        scrollView.stackView.addArrangedSubview(productDetailsView)
        productDetailsView.translatesAutoresizingMaskIntoConstraints = false
        productDetailsView.heightAnchor.constraint(equalToConstant: 415).isActive = true
    }

    fileprivate func setupOptionsView() {
        productOptionsView.viewModel = viewModel
       scrollView.stackView.addArrangedSubview(productOptionsView)
        productOptionsView.translatesAutoresizingMaskIntoConstraints = false
        productOptionsView.heightAnchor.constraint(equalToConstant: 54).isActive = true
    }

    fileprivate func setupPriceButton() {
        guard let viewModel = viewModel else { return }

        let containerView = UIView()
        scrollView.stackView.addArrangedSubview(containerView)

        priceButton.setBackgroundImage(UIImage(named: "price _rounded_rectangle"), for: .normal)
        priceButton.setTitleColor(.brandDarkBlue, for: .normal)
        priceButton.setTitle(viewModel.price, for: .normal)

        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        containerView.centerXAnchor.constraint(equalTo: scrollView.stackView.centerXAnchor).isActive = true

        containerView.addSubview(priceButton)

        priceButton.translatesAutoresizingMaskIntoConstraints = false
        priceButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        priceButton.widthAnchor.constraint(equalToConstant: 120).isActive = true
        priceButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        priceButton.actionHandle(controlEvents: .touchUpInside) {
            self.addToCartAction()
        }
    }

    @IBAction func Add_Cart(_ sender: Any) {

        addToCartAction()
        let controller = UIStoryboard(name: "Cart", bundle: Bundle.main).instantiateViewController(withIdentifier: "NewCartViewController") as! NewCartViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
    //MARK:- IBActions
    func addToCartAction() {
        guard let viewModel = viewModel else { return }
        viewModel.addToCart()
    }

}
extension ProductDetailsViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
  
        if section == 0 {
            return 1
        }
        if section == 1 {
            return productOptionCellNUmber
        }
        if section == 2 {
            return 1
        }else{
            return 0
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0{
               return 407
        }
        if indexPath.section == 1{
            return 60
        }
        if indexPath.section == 2{
              return 200
            
        }else{
            return 0
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "productDeatailsTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! productDeatailsTableViewCell
        
        if  indexPath.section == 0 {

            self.productDetailsView.viewModel = viewModel
            self.productDetailsView.loadData()
            cell.addSubview(self.productDetailsView)

        }
        if  indexPath.section == 1 {
                if indexPath.row == 0{
                    productOptionsView.viewModel = viewModel
                    cell.addSubview(productOptionsView)
                }else {
                      let SelectOptionProductView: SelectOptionProduct = .fromNib()
                      cell.addSubview(SelectOptionProductView)
                }
            }
        if  indexPath.section == 2
            {
                
            }
  
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            if  indexPath.section == 1 {
                let clciked =  UserDefaults.standard.value(forKey: "Clicked") as! String
                if clciked == "1"{
                    productOptionCellNUmber = 1
                     UserDefaults.standard.set("0", forKey: "Clicked")
                    
                }else{
                    UserDefaults.standard.set("1", forKey: "Clicked")
                    productOptionCellNUmber = 3
                  
                }
                
      
            }
        
          product_Tableview.reloadData()
    }
    
  
}

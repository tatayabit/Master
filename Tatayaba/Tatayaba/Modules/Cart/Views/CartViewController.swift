//
//  NewCartViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/10/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CartViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, CartViewModelDelegate {
    
    @IBOutlet var cartTableview: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var checkoutContainerView: UIView!
    @IBOutlet weak var couponContainerView: UIStackView!
    @IBOutlet weak var couponTextField: UITextField!
    @IBOutlet weak var removeDiscountButton: UIButton!
    
    
    let cart = Cart.shared
    let viewModel = CartViewModel()
    // let we say until now (One_Click_Buy = 1 & Default_Way = 0)
    var buyingWayType: Int = 0
    var couponValue: String = "0"
    var taxValue: Tax?
    var shippingValue: String = "0"
    var maxValueToShowTax: Float = 200
    var totalPriceValue: Float = 0
    private let checkoutSegue = "checkout_segue"
    
    enum sectionType: Int {
        case item = 0, pricing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        viewModel.delegate = self
        cartTableview.separatorColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.setOneClickBuy(isOneClickBuy: (buyingWayType > 0))
        calculateTotal()
        loadTaxAndShipping()
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK:- setupUI
    func setupUI() {
        cartTableview.register(PriceTableViewCell.nib, forCellReuseIdentifier: PriceTableViewCell.identifier)
        self.NavigationBarWithOutBackButton()
        removeDiscountButton.isHidden = true
    }
    
    func calculateTotal() {
        totalPriceValue = (cart.totalPrice as NSString).floatValue + (couponValue as NSString).floatValue  + (shippingValue as NSString).floatValue
        if let taxStringValue = taxValue?.vat?.value, totalPriceValue >= maxValueToShowTax {
            if taxValue?.vat?.type == "P" {
                totalPriceValue += (totalPriceValue * (Float(taxStringValue)!)) / 100
            } else {
                totalPriceValue += Float(taxStringValue) ?? 0.0
            }
        }
        
        totalPriceLabel.text = "\(totalPriceValue)"
        viewModel.loadPricingListContent(couponValue: couponValue, taxValue: taxValue, shippingValue: shippingValue)
        let totalItemsText = "(" + String(cart.productsCount) + " " + Constants.Cart.items + ")"
        totalTitleLabel.attributedText = attributedTotalTitle(text: totalItemsText)
    }
    
    func attributedTotalTitle(text: String) -> NSAttributedString {
        let textVal = Constants.Cart.cartTotal + " " + text
        
        let strokeTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(hexString: "221C35"),
            NSAttributedString.Key.font : UIFont.lightGotham(size: 11)
            ] as [NSAttributedString.Key : Any]
        
        let newStr = NSMutableAttributedString(string: textVal)
        newStr.addAttributes(strokeTextAttributes, range: (textVal as NSString).range(of: text))
        return newStr
    }
    
    func addOneMoreAction(indexPath: IndexPath) {
        let cartProduct = cart.product(at: indexPath)
        cart.increaseCount(cartItem: cartProduct.1,quantity: 1)
        calculateTotal()
    }
    
    func removeOneAction(indexPath: IndexPath) {
        let cartProduct = cart.product(at: indexPath)
        cart.decreaseCount(cartItem: cartProduct.1)
        calculateTotal()
    }
    
    func removeItemAction(indexPath: IndexPath) {
        cart.removeProduct(at: indexPath)
        calculateTotal()
    }
    
    // MARK:- UITableView - Header
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case sectionType.pricing.rawValue:
            //            let pricingCount = viewModel.pricingList.count
            //            let height = pricingCount > 0 ? 8 : 0
            //            return CGFloat(height)
            return 0
        default: return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if cart.productsCount > 0 {
            self.cartTableview.restore()
            checkoutContainerView.isHidden = false
            couponContainerView.isHidden = false
        } else {
            self.cartTableview.setEmptyMessage(Constants.Cart.cartEmpty)
            checkoutContainerView.isHidden = true
            couponContainerView.isHidden = true
            return 0
        }
        
        if viewModel.pricingList.count > 0 {
            return (couponValue as NSString).integerValue > 0 ? 3 : 2
        }
        return 1
    }
    
    // MARK:- UITableViewDataSource - Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case sectionType.item.rawValue:
            return 100
        case sectionType.pricing.rawValue:
            return 50
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case sectionType.item.rawValue:
            return cart.productsCount
        case sectionType.pricing.rawValue:
            if totalPriceValue < maxValueToShowTax {
                viewModel.pricingList.removeAll(where: {$0.title == "Tax"})
            }
            let pricingCount = viewModel.pricingList.count
            return (couponValue as NSString).integerValue > 0 ? pricingCount : pricingCount - 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case sectionType.item.rawValue:
            return getItemCell(tableView: tableView, indexPath: indexPath)
            
        case sectionType.pricing.rawValue:
            return getPricingCell(tableView:tableView, indexPath: indexPath)
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
            return cell
        }
    }
    
    // MARK:- CartTableViewCell
    func getItemCell(tableView: UITableView, indexPath: IndexPath) -> CartTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell
        
        let cartProduct = cart.product(at: indexPath)
        cell.configure(product: cartProduct.0, cartItem: cartProduct.1)
        
        cell.onAddMoreClick = {
            let maxQuantity = cartProduct.0.maxQuantity
            let currentQuantity = cell.quantityCoutLabel.text ?? "0"
            if let max = Int(maxQuantity), max <= Int(currentQuantity) ?? 0 {
                // max reached
            } else {
                self.addOneMoreAction(indexPath: indexPath)
                cell.updatePrice(product: cartProduct.0, cartItem: cartProduct.1)
            }
        }
        
        cell.onRemoveOneCountClick = {
            self.removeOneAction(indexPath: indexPath)
            cell.updatePrice(product: cartProduct.0, cartItem: cartProduct.1)
        }
        
        cell.onRemoveItemClick = {
            self.removeItemAction(indexPath: indexPath)
            cell.updatePrice(product: cartProduct.0, cartItem: cartProduct.1)
        }
        
        return cell
    }
    
    func getPricingCell(tableView: UITableView, indexPath: IndexPath) -> PriceTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PriceTableViewCell.identifier, for: indexPath) as! PriceTableViewCell
        
        let pricingModel = viewModel.pricingList[indexPath.row]
        cell.configure(title: pricingModel.title, value: pricingModel.value)
        return cell
    }
    
    // MARK:- CartViewModelDelegate
    func didFinishLoadingPricing() {
        cartTableview.reloadData()
    }
    
    //MARK:- IBActions
    @IBAction func checkoutAction(_ sender: Any) {
        performSegue(withIdentifier: checkoutSegue, sender: nil)
    }
    
    @IBAction func removeCouponAction(_ sender: UIButton) {
        couponValue = "0"
        calculateTotal()
        self.setButton(button: removeDiscountButton, hidden: true)
        self.showErrorAlerr(title: Constants.Common.success, message: "CouponRemovedSuccessfully".localized(), handler: nil)
    }
    
    func loadTaxAndShipping() {
        showLoadingIndicator(to: self.view)
        viewModel.getTaxAndShipping(countryCode: "KW") { result in
            self.hideLoadingIndicator(from: self.view)
            switch result {
            case .success(let taxAndShippingResponse):
                if let taxAndShippingResponse = taxAndShippingResponse {
                    if let taxValue = taxAndShippingResponse.tax {
                        print(taxValue)
                        self.taxValue = taxValue
                        self.calculateTotal()
                        CountrySettings.shared.updateTax(taxValue: taxValue)
                    }
                    
                    if let shipping = taxAndShippingResponse.shipping {
                        if let shippingValue = shipping.rateValue {
                            print(shippingValue)
                            self.shippingValue = "\(shippingValue)"
                            self.calculateTotal()
                            CountrySettings.shared.updateShipping(shippingValue: shipping)
                        }
                    }
                    
                    if let paymentMethods = taxAndShippingResponse.paymentMethods {
                        CountrySettings.shared.updatePaymentsMethods(list: paymentMethods)
                    }
                }
                
                
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    @IBAction func applyCouponAction(_ sender: UIButton) {
        if let couponValue = couponTextField.text, couponValue != "" {
            showLoadingIndicator(to: self.view)
            viewModel.applyCoupon(couponCode: couponValue) { result in
                self.hideLoadingIndicator(from: self.view)
                switch result {
                case .success(let couponResult):
                    if let couponDiscound = couponResult?.total {
                        print(couponDiscound)
                        self.couponValue = "\(couponDiscound)"
                        self.calculateTotal()
                        self.couponTextField.text = ""
                        self.setButton(button: self.removeDiscountButton, hidden: false)
                        self.showErrorAlerr(title: Constants.Common.success, message: "CouponAddedSuccessfully".localized(), handler: nil)
                    } else {
                        print("no coupon discound parsed")
                    }
                case .failure(let error):
                    print("the error \(error)")
                }
            }
        } else {
            showErrorAlerr(title: Constants.Common.error, message: "Please enter coupon value!".localized(), handler: nil)
        }
    }
}

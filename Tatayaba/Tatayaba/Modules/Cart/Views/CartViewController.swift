//
//  NewCartViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/10/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

private enum BonusTypes: String, CaseIterable {
    case orderDiscount = "order_discount"
}

private enum DiscountBonusTypes: String, CaseIterable {
    case toPercentage = "to_percentage"
    case byPercentage = "by_percentage"
    case toFixed = "to_fixed"
    case byFixed = "by_fixed"
}


class CartViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, CartViewModelDelegate, CountrySettingsDelegate {
    
    @IBOutlet var cartTableview: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var checkoutContainerView: UIView!
    @IBOutlet weak var couponContainerView: UIStackView!
    @IBOutlet weak var couponTextField: UITextField!
    @IBOutlet weak var removeDiscountButton: UIButton!
    @IBOutlet weak var couponTextFieldView: UIView!
    
    
    let cart = Cart.shared
    let viewModel = CartViewModel()
    // let we say until now (One_Click_Buy = 1 & Default_Way = 0)
    var buyingWayType: Int = 0
    var couponTitleValue: String = "0"
    var taxValue: Tax?
    var shippingValue: String = "0"
    var maxValueToShowTax: Float = 0
    var totalPriceValue: Float = 0
    private let checkoutSegue = "checkout_segue"
    let cartClass: CartPricingItems = CartPricingItems()
    var promotionData : PromotionData?
    var forcedFreeDelivery = false

    var totalPriceValueRounded:Float = 0.0 {
        didSet {
            cart.totalPriceValueRounded = totalPriceValueRounded
        }
    }
    let resetVCNotification = "resetVCNotification"
    
    enum sectionType: Int {
        case item = 0, pricing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        CountrySettings.shared.addDelegate(delegate: self)
        viewModel.delegate = self
        cartTableview.separatorColor = .clear
        NotificationCenter.default.addObserver(self, selector: #selector(resetAllData), name: NSNotification.Name(resetVCNotification), object: nil)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadUIData()
        setupTabBar()
    }
    
    func reloadUIData() {
        viewModel.setOneClickBuy(isOneClickBuy: (buyingWayType > 0))
        calculateTotal()
        loadTaxAndShipping()
    }
    
    func setupTabBar() {
//        if AppDelegate.shared.rootViewController.selectedIndex == 4 {
            self.NavigationBarWithOutBackButton()
            //self.NavigationBarWithBackButton()
//            AppDelegate.shared.rootViewController.tabBar.isHidden = false
//        } else {
//            self.NavigationBarWithBackButton()
//            AppDelegate.shared.rootViewController.tabBar.isHidden = true
//        }
    }

    
    // MARK:- setupUI
    func setupUI() {
        cartTableview.register(PriceTableViewCell.nib, forCellReuseIdentifier: PriceTableViewCell.identifier)
        removeDiscountButton.isHidden = true
        couponTextFieldView.isHidden = false
    }
    
    func calculateTotal() {
        
        if self.hasFreeShippingDiscount() {
            self.calculateTotalWithFreeShippingCoupon()
            return
        }
        
        totalPriceValue = (cart.totalPrice as NSString).floatValue + (shippingValue as NSString).floatValue
        if totalPriceValue >= maxValueToShowTax && maxValueToShowTax != 0 {
            if let customDutiesStringValue = taxValue?.customDuties?.value {
                if taxValue?.customDuties?.type == "P" {
                    totalPriceValue += (totalPriceValue * (Float(customDutiesStringValue)!)) / 100
                } else {
                    totalPriceValue += Float(customDutiesStringValue) ?? 0.0
                }
            }
        }
        
        if let taxStringValue = taxValue?.vat?.value {
            if taxValue?.vat?.type == "P" {
                totalPriceValue += (totalPriceValue * (Float(taxStringValue)!)) / 100
            } else {
                totalPriceValue += Float(taxStringValue) ?? 0.0
            }
        }
        
        if promotionData != nil {
            let discountItem = promotionData?.bonuses?.first
            let currentTotal = (cart.totalPrice as NSString).floatValue
            if discountItem?.discountBonus == DiscountBonusTypes.byPercentage.rawValue {
                let discountValueFromTotal = (currentTotal * ("\(discountItem?.discountValue ?? "0")" as NSString).floatValue) / 100
                totalPriceValue = totalPriceValue - discountValueFromTotal
                if let promoName = promotionData?.promoName {
                    couponTitleValue = promoName
                } else {
                    couponTitleValue = "by \(discountItem?.discountValue ?? "0")%"
                }
            } else if discountItem?.discountBonus == DiscountBonusTypes.toPercentage.rawValue {
                let discountValueFromTotal = (currentTotal * ("\(discountItem?.discountValue ?? "0")" as NSString).floatValue) / 100
                totalPriceValue = discountValueFromTotal
                if let promoName = promotionData?.promoName {
                    couponTitleValue = promoName
                } else {
                    couponTitleValue = "to \(discountItem?.discountValue ?? "0")%"
                }
            } else if discountItem?.discountBonus == DiscountBonusTypes.byFixed.rawValue {
                let discountValueFromTotal = ("\(discountItem?.discountValue ?? "0")" as NSString).floatValue
                totalPriceValue = totalPriceValue - discountValueFromTotal
                if let promoName = promotionData?.promoName {
                    couponTitleValue = promoName
                } else {
                    couponTitleValue = "by \((discountItem?.discountValue ?? "0").formattedPrice)"
                }
            } else if discountItem?.discountBonus == DiscountBonusTypes.toFixed.rawValue {
                let discountValueFromTotal = totalPriceValue - ("\(discountItem?.discountValue ?? "0")" as NSString).floatValue
                totalPriceValue = discountValueFromTotal
                if let promoName = promotionData?.promoName {
                    couponTitleValue = promoName
                } else {
                    couponTitleValue = "to \((discountItem?.discountValue ?? "0").formattedPrice)"
                }
            }
        }
        
        totalPriceValueRounded = (totalPriceValue * 100).rounded() / 100
        
        totalPriceLabel.text = "\(totalPriceValueRounded)".formattedPrice
        viewModel.loadPricingListContent(couponValue: couponTitleValue, taxValue: taxValue, shippingValue: shippingValue)
        let totalItemsText = "(" + String(cart.productsCount) + " " + cartClass.items + ")"
        totalTitleLabel.attributedText = attributedTotalTitle(text: totalItemsText)
    }
    
    private func calculateTotalWithFreeShippingCoupon() {
        
        totalPriceValue = (cart.totalPrice as NSString).floatValue
        
        if totalPriceValue >= maxValueToShowTax && maxValueToShowTax != 0 {
            if let customDutiesStringValue = taxValue?.customDuties?.value {
                if taxValue?.customDuties?.type == "P" {
                    totalPriceValue += (totalPriceValue * (Float(customDutiesStringValue)!)) / 100
                } else {
                    totalPriceValue += Float(customDutiesStringValue) ?? 0.0
                }
            }
        }
        
        if let taxStringValue = taxValue?.vat?.value {
            if taxValue?.vat?.type == "P" {
                totalPriceValue += (totalPriceValue * (Float(taxStringValue)!)) / 100
            } else {
                totalPriceValue += Float(taxStringValue) ?? 0.0
            }
        }
        
        totalPriceValue += (shippingValue as NSString).floatValue
        
        if promotionData != nil {
            let discountItem = promotionData?.bonuses?.first
            let currentTotal = (cart.totalPrice as NSString).floatValue//totalPriceValue
            if discountItem?.discountBonus == DiscountBonusTypes.byPercentage.rawValue {
                let discountValueFromTotal = (currentTotal * ("\(discountItem?.discountValue ?? "0")" as NSString).floatValue) / 100
                totalPriceValue = totalPriceValue - discountValueFromTotal
                if let promoName = promotionData?.promoName {
                    couponTitleValue = promoName
                } else {
                    couponTitleValue = "by \(discountItem?.discountValue ?? "0")%"
                }
            } else if discountItem?.discountBonus == DiscountBonusTypes.toPercentage.rawValue {
                let discountValueFromTotal = (currentTotal * ("\(discountItem?.discountValue ?? "0")" as NSString).floatValue) / 100
                totalPriceValue = discountValueFromTotal
                if let promoName = promotionData?.promoName {
                    couponTitleValue = promoName
                } else {
                    couponTitleValue = "to \(discountItem?.discountValue ?? "0")%"
                }
            } else if discountItem?.discountBonus == DiscountBonusTypes.byFixed.rawValue {
                let discountValueFromTotal = ("\(discountItem?.discountValue ?? "0")" as NSString).floatValue
                totalPriceValue = totalPriceValue - discountValueFromTotal
                if let promoName = promotionData?.promoName {
                    couponTitleValue = promoName
                } else {
                    couponTitleValue = "by \((discountItem?.discountValue ?? "0").formattedPrice)"
                }
            } else if discountItem?.discountBonus == DiscountBonusTypes.toFixed.rawValue {
                let discountValueFromTotal = totalPriceValue - ("\(discountItem?.discountValue ?? "0")" as NSString).floatValue
                totalPriceValue = discountValueFromTotal
                if let promoName = promotionData?.promoName {
                    couponTitleValue = promoName
                } else {
                    couponTitleValue = "to \((discountItem?.discountValue ?? "0").formattedPrice)"
                }
            }
        }
        
        totalPriceValueRounded = (totalPriceValue * 100).rounded() / 100
        
        totalPriceLabel.text = "\(totalPriceValueRounded)".formattedPrice
        viewModel.loadPricingListContent(couponValue: couponTitleValue, taxValue: taxValue, shippingValue: shippingValue, freeShipping: true)
        let totalItemsText = "(" + String(cart.productsCount) + " " + cartClass.items + ")"
        totalTitleLabel.attributedText = attributedTotalTitle(text: totalItemsText)
    }
    
    public func getCalculatedTotal() -> Float {
        return self.totalPriceValueRounded
    }
    private func hasFreeShippingDiscount() -> Bool {
        if self.forcedFreeDelivery {
            return true
        }
        if let promotionData = promotionData {
            if let promotionName = promotionData.promoName {
                if promotionName.lowercased().contains("free delivery") {
                    return true
                }
            }
        }
        return false
    }
    
    func attributedTotalTitle(text: String) -> NSAttributedString {
        let textVal = cartClass.cartTotal + " " + text
        
        let strokeTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor.brandDarkBlue
//            ,NSAttributedString.Key.font : UIFont.lightGotham(size: 11)
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
            self.cartTableview.setEmptyMessage(cartClass.cartEmpty)
            checkoutContainerView.isHidden = true
            couponContainerView.isHidden = true
            return 0
        }
        
        if viewModel.pricingList.count > 0 {
            if promotionData != nil {
               return 3
            } else {
                return 2
            }
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
            if ("\(taxValue?.vat?.value ?? "0")" as NSString).floatValue == 0 {
                viewModel.pricingList.removeAll(where: {$0.title == "Tax".localized()})
            }
            if totalPriceValue < maxValueToShowTax || maxValueToShowTax == 0 {
                viewModel.pricingList.removeAll(where: {$0.title == "CustomDuties".localized()})
            }
            let pricingCount = viewModel.pricingList.count
            if promotionData != nil {
                return pricingCount
            } else {
                return pricingCount - 1
            }
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
            let maxQuantity = Int(cartProduct.0.maxQuantity) ?? 0
            let stockQuantity = cartProduct.0.amount
            let currentQuantity = cell.quantityCoutLabel.text ?? "0"
            var max = (stockQuantity > maxQuantity) ? maxQuantity : stockQuantity

            if cartProduct.0.isOutOfStockActionB {
                max = maxQuantity
            }
            
            if  max <= Int(currentQuantity) ?? 0 {
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
    
    // MARK:- ResetCartViewController
    @objc func resetAllData() {
        couponTitleValue = "0"
        promotionData = nil
        calculateTotal()
        self.setButton(button: removeDiscountButton, hidden: true)
        self.setView(view: couponTextFieldView, hidden: false)
        self.removeDiscountButton.isHidden = true
        self.couponTextField.text = ""
    }
    
    // MARK:- CountrySettingsDelegate
    func countryDidChange(to country: Country) {
        print("country changes!!!")
        print("CartViewController")
//        viewModel.clearCart()
        reloadUIData()
     }
    
    //MARK:- Apply Silent free delivery coupon
    func applySilentFreeDeliveryCoupon() {
        if viewModel.shouldApplyFreeShippingCoupon() {
            viewModel.applySilentFreeShippingCoupon { result in
                switch result {
                case .success(let couponResult):
                    if let promotionValue = couponResult?.promotionData {
                        print(promotionValue)
                        if promotionValue.errorMessage == nil {
                            if promotionValue.bonuses?.first?.bonus == BonusTypes.orderDiscount.rawValue {
//                                self.promotionData = promotionValue
                                self.forcedFreeDelivery = true
                                self.shippingValue = "0.000"
                                self.viewModel.loadPricingListContent(couponValue: self.couponTitleValue, taxValue: self.taxValue, shippingValue: self.shippingValue, freeShipping: true)
                                self.calculateTotal()
                                self.cartTableview.reloadData()
                            }
                        }
                        
                    } else {
                        print("no coupon discound parsed")
                    }
                case .failure(let error):
                    print("the error \(error)")
                }
            }
        }
    }
    
    //MARK:- IBActions
    @IBAction func checkoutAction(_ sender: Any) {
        performSegue(withIdentifier: checkoutSegue, sender: nil)
    }
    
    @IBAction func removeCouponAction(_ sender: UIButton) {
        couponTitleValue = "0"
        promotionData = nil
        calculateTotal()
        self.setButton(button: removeDiscountButton, hidden: true)
        self.setView(view: couponTextFieldView, hidden: false)
        self.showErrorAlerr(title: Constants.Common.success, message: "CouponRemovedSuccessfully".localized(), handler: nil)
    }
    
    func loadTaxAndShipping() {
        showLoadingIndicator(to: self.view)
        let countryCode = CountrySettings.shared.currentCountry?.code ?? "KW"
        viewModel.getTaxAndShipping(countryCode: countryCode) { result in
            switch result {
            case .success(let taxAndShippingResponse):
                if let taxAndShippingResponse = taxAndShippingResponse {
                    if let taxValue = taxAndShippingResponse.tax {
                        print(taxValue)
                        self.taxValue = taxValue
                        self.maxValueToShowTax = ("\(taxValue.customDuties?.cartTotalThreshold ?? "0")" as NSString).floatValue
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
                    if self.cart.productsList().count == 0 {
                        self.hideLoadingIndicator(from: self.view)
                        return
                    }
                    self.updateShippingCurrency()
                    
                } else {
                    self.hideLoadingIndicator(from: self.view)
                }
                self.applySilentFreeDeliveryCoupon()
                
            case .failure(let error):
                self.hideLoadingIndicator(from: self.view)
                print("the error \(error)")
                self.applySilentFreeDeliveryCoupon()
            }
        }
    }
    
    func updateShippingCurrency() {
        viewModel.getShippingPricesWithUpdatedCurrency { result in
            self.hideLoadingIndicator(from: self.view)

            switch result {
            case .success(let convertedPricesResult):
                if let shippingValue = CountrySettings.shared.shipping?.rateValue {
                    self.shippingValue = shippingValue
                }
                
                if let convertedPrices = convertedPricesResult {

                    print(convertedPrices)
                    
                    if var tax = CountrySettings.shared.tax {
                          // check VAT
                        if var vat = tax.vat {
                            if vat.type != "P" {
                                vat.value = convertedPrices.vatAmount
                            }
                        }
                        
                        // check CustomDuties
                        if var customDuties = tax.customDuties {
                          customDuties.cartTotalThreshold = convertedPrices.cartTotalThreshold
                          tax.customDuties = customDuties
                        }
                        
                        self.taxValue = tax
                        self.maxValueToShowTax = ("\(self.taxValue?.customDuties?.cartTotalThreshold ?? "0")" as NSString).floatValue
                        CountrySettings.shared.updateTax(taxValue: tax)
                    }
                }

                self.calculateTotal()
                
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
    
    
    @IBAction func applyCouponAction(_ sender: UIButton) {
        if let couponValue = couponTextField.text, couponValue != "" {
            showLoadingIndicator(to: self.view)
            viewModel.applyCoupon(couponCode: couponValue, email: Customer.shared.user?.email ?? "") { result in
                self.hideLoadingIndicator(from: self.view)
                switch result {
                case .success(let couponResult):
                    if let promotionValue = couponResult?.promotionData {
                        print(promotionValue)
                        if promotionValue.errorMessage == nil {
                            if promotionValue.bonuses?.first?.bonus == BonusTypes.orderDiscount.rawValue {
                                self.promotionData = promotionValue
                                let trimmedCodeString = (self.couponTextField.text)?.trimmingCharacters(in: .whitespaces)

                                self.cart.couponCode = trimmedCodeString ?? ""
                                self.calculateTotal()
                                self.couponTextField.text = ""
                                self.couponTextFieldView.endEditing(true)
                                self.setView(view: self.couponTextFieldView, hidden: true)
                                self.setButton(button: self.removeDiscountButton, hidden: false)
                                self.showErrorAlerr(title: Constants.Common.success, message: "CouponAddedSuccessfully".localized(), handler: nil)
                            } else {
                                self.showErrorAlerr(title: Constants.Common.success, message: "couponTypeNotImplemented".localized(), handler: nil)
                            }
                            
                        } else {
                            self.couponTextField.text = ""
                            self.couponTextFieldView.endEditing(true)
                            self.showErrorAlerr(title: Constants.Common.error, message: promotionValue.errorMessage, handler: nil)
                        }
                        
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

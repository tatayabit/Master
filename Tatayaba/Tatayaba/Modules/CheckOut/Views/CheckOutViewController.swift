//
//  CheckOutViewController.swift
//  Tatayaba
//
//  Created by Admin on 19/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SwiftValidator

class CheckOutViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, CountrySettingsDelegate {
    
    @IBOutlet weak var paymentTableView: UITableView!

    private let viewModel = CheckOutViewModel()
    
    let checkoutCompletedSegue = "checkout_completed_segue"
    let paymentWebViewSegue = "payment_web_view_segue"
    
    enum sectionType: Int {
        case payment = 0, address
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // self.updateData()
        CountrySettings.shared.addDelegate(delegate: self)
        viewModel.onPaymentMethodsListLoad = {
            self.paymentTableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        paymentTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if ((Customer.shared.user?.identifier) == "") {
            Customer.shared.logout()
        }
    }
    
    func formValidator() {
        
    }
    
    func updateData() {
        //        subTotalValueLabel.text = viewModel.subTotalValue
        //        totalPriceButton.setTitle(viewModel.totalValue, for: .normal)
        //        shippingValueLabel.text = viewModel.shippingValue
    }
    
    
    func setupUI() {
        self.tabBarController?.tabBar.isHidden = true
        NavigationBarWithBackButton()
        self.paymentTableView.register(PaymentMethodTableViewCell.nib, forCellReuseIdentifier: PaymentMethodTableViewCell.identifier)
        self.paymentTableView.register(CheckoutAddressTableViewCell.nib, forCellReuseIdentifier: CheckoutAddressTableViewCell.identifier)
    }
    
    func validationFailed(_ errors: [(Validatable, ValidationError)]) {
        print("Validation FAILED!")
        if errors.count > 0 {
            self.showErrorAlerr(title: Constants.Common.error, message: errors[0].1.errorMessage, handler: nil)
        }
        
        for error in errors {
            print("errors:::: \(String(describing: error.1.errorMessage))")
        }
        
    }
    
    //MARK:- IBActions
    @IBAction func placeOrderAction(_ sender: Any) {
        
        print((Customer.shared.checkAddressData()) && (Customer.shared.user?.email != nil) && (Cart.shared.isOneClickBuy))
        if !((Customer.shared.checkAddressData()) && (Customer.shared.user?.email != nil) && (Cart.shared.isOneClickBuy)) {
            showErrorAlerr(title: Constants.Common.error, message: "Please Enter Adderess", handler: nil)
        } else {
            //         self.performSegue(withIdentifier: self.checkoutCompletedSegue, sender: nil)
            self.showLoadingIndicator(to: self.view)
            if let user = Customer.shared.user {
                viewModel.placeOrder(userData: user) { result in
                    self.hideLoadingIndicator(from: self.view)
                    switch result {
                    case .success(let response):
                        guard let placeOrderResult = response else { return }
                        print(placeOrderResult)
                        if placeOrderResult.orderId > 0 {
                            
                            self.orderSuccessFlow(result: placeOrderResult)
                        } else {
                            print("the error order id == \(placeOrderResult.orderId)")
                            self.showErrorAlerr(title: Constants.Common.error, message: "Placing order failed", handler: nil)
                        }
                        
                    case .failure(let error):
                        print("the error \(error)")

                        if let response = error.response {
                            do {
                                
                                let decoder = JSONDecoder()
                                let errorMessage = try decoder.decode(ErrorMessage.self, from: response.data)
                                  print(errorMessage)
                                self.showErrorAlerr(title: Constants.Common.error, message: errorMessage.message, handler: nil)
                            } catch let errX {
                                print("errX: ", errX)
                            }
                        } else {
                            self.showErrorAlerr(title: Constants.Common.error, message: error.localizedDescription, handler: nil)

                        }
                    }
                }
            }
        }
    }
    
    
    // MARK: - Placing Order Success Flow
    func orderSuccessFlow(result: PlaceOrderResult) {
        // need to be updated to not COD
        if !viewModel.isCashOnDelivery {
            if result.redirectUrl.count == 0 {
                print("the error order id == \(result.orderId)")
                self.showErrorAlerr(title: Constants.Common.error, message: "Couldn't get the payment URL", handler: nil)
                return
            }
            self.performSegue(withIdentifier: self.paymentWebViewSegue, sender: result)
        } else {
            self.performSegue(withIdentifier: self.checkoutCompletedSegue, sender: result)
        }
    }
}

//Tableview
extension CheckOutViewController {
    
    // MARK:- UITableView - Header
    func numberOfSections(in tableView: UITableView) -> Int {
        //        if viewModel.pricingList.count > 0 {
        //            return 2
        //        }
        return 2
    }
    
    // MARK:- UITableViewDelegate - Cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case sectionType.payment.rawValue:
            viewModel.selectPaymentMethod(at: indexPath)
            tableView.reloadData()
        default: break
        }
    }
    
    // MARK:- UITableViewDataSource - Cell
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case sectionType.payment.rawValue:
            return 60
        case sectionType.address.rawValue:
            return 100
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case sectionType.payment.rawValue:
            return viewModel.paymentMethods.count
        case sectionType.address.rawValue:
            return 1
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case sectionType.payment.rawValue:
            return getPaymentCell(tableView: tableView, indexPath: indexPath)
            
        case sectionType.address.rawValue:
            return getAddressCell(tableView: tableView, indexPath: indexPath)
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentMethodTableViewCell.identifier, for: indexPath) as! PaymentMethodTableViewCell
            return cell
        }
    }
    
    // MARK:- PaymentSelectionViewCell
    func getPaymentCell(tableView: UITableView, indexPath: IndexPath) -> PaymentMethodTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentMethodTableViewCell.identifier, for: indexPath) as! PaymentMethodTableViewCell
        
        cell.configure(payment: viewModel.paymentMethods[indexPath.row])
        return cell
    }
    
    // MARK:- CheckoutAddressTableViewCell
    func getAddressCell(tableView: UITableView, indexPath: IndexPath) -> CheckoutAddressTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CheckoutAddressTableViewCell.identifier, for: indexPath) as! CheckoutAddressTableViewCell
        cell.editButton.addTarget(self, action: #selector(EditAddressButton), for: .touchUpInside)
        if let currentUser = Customer.shared.user {
            cell.configure(user: currentUser)
        }else {
            let guestUser = User(email: "", password: "")
            cell.configure(user: guestUser)
        }
        
        return cell
    }
    
    @objc func EditAddressButton() {
        let controller = UIStoryboard(name: "Addresses", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddressAddEditViewController") as! AddressAddEditViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
    
    // MARK:- CountrySettingsDelegate
    func countryDidChange(to country: Country) {
        print("country changes!!!")
        print("CheckOutViewController")
        self.navigationController?.popToRootViewController(animated: false)
    }

    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == paymentWebViewSegue {
            let productDetailsVC = segue.destination as! PaymentWebViewController
            if let orderResult = sender as? PlaceOrderResult {
                productDetailsVC.viewModel = viewModel.paymentWebViewModel(orderResult: orderResult)
            }
        }
        
        if segue.identifier == checkoutCompletedSegue {
            let completedCheckoutVC = segue.destination as! CheckoutCompletedViewController
            if let orderResult = sender as? PlaceOrderResult {
                completedCheckoutVC.viewModel = viewModel.checkoutCompletedViewModel(orderId: "\(orderResult.orderId)")
            }
        }
    }
}

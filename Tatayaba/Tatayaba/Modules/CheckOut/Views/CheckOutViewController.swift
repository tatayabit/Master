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

class CheckOutViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource,ValidationDelegate{
    
    @IBOutlet weak var paymentTableView: UITableView!
    @IBOutlet weak var guestCompletDataView: UIView!
    @IBOutlet weak private var emailTextField: SkyFloatingLabelTextField!
    @IBOutlet weak private var passwordTextField: SkyFloatingLabelTextField!
    private let viewModel = CheckOutViewModel()
    private let validator = Validator()
    private var user: User?
    
    let checkoutCompletedSegue = "checkout_completed_segue"
    enum sectionType: Int {
        case payment = 0, address
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // self.updateData()
        viewModel.onPaymentMethodsListLoad = {
            self.paymentTableView.reloadData()
        }
        formValidator()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        paymentTableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if ((Customer.shared.user?.email) == "") {
            Customer.shared.logout()
        }
    }
    
    func formValidator() {
        validator.registerField(emailTextField, rules: [RequiredRule(message: "Email is required!"), EmailRule(message: "Invalid email")])
        validator.registerField(passwordTextField, rules: [RequiredRule(message: "Password is required!"), PasswordRule(regex: "^.{6,20}$", message: "Invalid password")])
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
    
    //MARK:- Validation Delegate
    func validationSuccessful() {
        print("Validation Success!")
        guard let email = emailTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        if var guestUser = Customer.shared.user {
            guestUser.email = email
            guestUser.password = password
            user = guestUser
            Customer.shared.setUser(guestUser)
            setView(view: guestCompletDataView, hidden: true)
        }
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
    
    @IBAction func saveDataBtnAction(_ sender: Any) {
        emailTextField.updateColors()
        passwordTextField.updateColors()
        validator.validate(self)
    }
    
    //MARK:- IBActions
    @IBAction func placeOrderAction(_ sender: Any) {
        if Customer.shared.user?.email == nil {
            showErrorAlerr(title: Constants.Common.error, message: "Please Enter Adderess", handler: nil)
        } else if Customer.shared.user?.email == "" {
            setView(view: guestCompletDataView, hidden: false)
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
                            self.performSegue(withIdentifier: self.checkoutCompletedSegue, sender: nil)
                        } else {
                            print("the error order id == \(placeOrderResult.orderId)")
                            self.showErrorAlerr(title: Constants.Common.error, message: "Placing order failed", handler: nil)
                        }
                        
                    case .failure(let error):
                        print("the error \(error)")
                        self.showErrorAlerr(title: Constants.Common.error, message: error.localizedDescription, handler: nil)
                    }
                }
            }
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
}

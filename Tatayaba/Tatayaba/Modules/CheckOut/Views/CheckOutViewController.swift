//
//  CheckOutViewController.swift
//  Tatayaba
//
//  Created by Admin on 19/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CheckOutViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var paymentTableView: UITableView!

    private let viewModel = CheckOutViewModel()

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
    }

    func updateData() {
//        subTotalValueLabel.text = viewModel.subTotalValue
//        totalPriceButton.setTitle(viewModel.totalValue, for: .normal)
//        shippingValueLabel.text = viewModel.shippingValue
    }
    
    
    func setupUI() {
        self.tabBarController?.tabBar.isHidden = true
//        self.NavigationBarWithOutBackButton()
        self.paymentTableView.register(PaymentMethodTableViewCell.nib, forCellReuseIdentifier: PaymentMethodTableViewCell.identifier)
        self.paymentTableView.register(CheckoutAddressTableViewCell.nib, forCellReuseIdentifier: CheckoutAddressTableViewCell.identifier)
    }

    //MARK:- IBActions
    @IBAction func placeOrderAction(_ sender: Any) {
        
//         self.performSegue(withIdentifier: self.checkoutCompletedSegue, sender: nil)
        self.showLoadingIndicator(to: self.view)
        viewModel.placeOrder { result in
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
//        cell.configure(payment: viewModel.paymentMethods[indexPath.row])
        return cell
    }
    
    @objc func EditAddressButton() {
        let controller = UIStoryboard(name: "Addresses", bundle: Bundle.main).instantiateViewController(withIdentifier: "AddressAddEditViewController") as! AddressAddEditViewController
        self.navigationController?.pushViewController(controller, animated: false)
    }
}

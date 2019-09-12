//
//  CheckOutViewController.swift
//  Tatayaba
//
//  Created by Admin on 19/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CheckOutViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

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
        self.NavigationBarWithOutBackButton()
        self.paymentTableView.register(PaymentSelectionViewCell.nib, forCellReuseIdentifier: PaymentSelectionViewCell.identifier)
    }

    //MARK:- IBActions

    @IBAction func placeOrderAction(_ sender: Any) {
        
         self.performSegue(withIdentifier: self.checkoutCompletedSegue, sender: nil)
//        viewModel.placeOrder { result in
//            switch result {
//            case .success(let response):
//                guard let placeOrderResult = response else { return }
//                //                guard let paymentMethods = paymentResult.paymentMethods else { return }
//
//                print(placeOrderResult)
//                if placeOrderResult.orderId > 0 {
//                    self.performSegue(withIdentifier: self.checkoutCompletedSegue, sender: nil)
//                } else {
//                    print("the error order id == \(placeOrderResult.orderId)")
//                }
//
//            case .failure(let error):
//                print("the error \(error)")
//            }
//        }
   }
}

//Tableview
extension CheckOutViewController {

    // MARK:- UITableView - Header
    func numberOfSections(in tableView: UITableView) -> Int {
//        if viewModel.pricingList.count > 0 {
//            return 2
//        }
        return 1
    }

    // MARK:- UITableViewDataSource - Cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch indexPath.section {
        case sectionType.payment.rawValue:
            return 80
//        case sectionType.pricing.rawValue:
//            return 50
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case sectionType.payment.rawValue:
            return viewModel.paymentMethods.count//cart.productsCount
//        case sectionType.pricing.rawValue:
//            return viewModel.pricingList.count
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case sectionType.payment.rawValue:
            return getPaymentCell(tableView: tableView, indexPath: indexPath)

//        case sectionType.pricing.rawValue:
//            return getPricingCell(tableView:tableView, indexPath: indexPath)
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: PaymentSelectionViewCell.identifier, for: indexPath) as! PaymentSelectionViewCell
            return cell
        }
    }

    // MARK:- CartTableViewCell
    func getPaymentCell(tableView: UITableView, indexPath: IndexPath) -> PaymentSelectionViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PaymentSelectionViewCell.identifier, for: indexPath) as! PaymentSelectionViewCell

        cell.configure(payment: viewModel.paymentMethods[indexPath.row])
        return cell
    }
}

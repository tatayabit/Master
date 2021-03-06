//
//  CheckoutCompletedViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/29/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CheckoutCompletedViewController: BaseViewController {

    var viewModel: CheckoutCompletedViewModel?
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var paymentDataLabel: UILabel!
    let resetCartVCNotification = "resetVCNotification"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        self.navigationController?.isNavigationBarHidden = true
        NotificationCenter.default.post(name: Notification.Name(rawValue: resetCartVCNotification), object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }

    func setupUI() {
        guard let viewModel = viewModel else { return }
        orderIdLabel.text = viewModel.orderIdText
        orderDateLabel.text = viewModel.orderDate
        paymentDataLabel.text = viewModel.paymentDetails
    }


    @IBAction func viewOrdersAction(_ sender: Any) {
        self.tabBarController?.tabBar.isHidden = false
        self.tabBarController?.selectedIndex = 3
        self.navigationController?.popToRootViewController(animated: false)
    }

}

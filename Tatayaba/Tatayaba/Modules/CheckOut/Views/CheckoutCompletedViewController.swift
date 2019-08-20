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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }

    func setupUI() {
        guard let viewModel = viewModel else { return }
        orderIdLabel.text = viewModel.orderIdText
    }
}

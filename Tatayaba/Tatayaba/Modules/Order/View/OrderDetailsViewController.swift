//
//  OrderDetailsViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/7/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class OrderDetailsViewController: BaseViewController {

    var viewModel: OrderDetailsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupListeners()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationBarWithBackButton()
    }

    func setupListeners() {
        self.showLoadingIndicator(to: self.view)
        viewModel?.onOrderLoad = {
            self.hideLoadingIndicator(from: self.view)
        }
    }
}

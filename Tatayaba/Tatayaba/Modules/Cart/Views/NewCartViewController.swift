//
//  NewCartViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/10/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class NewCartViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var cartTableview: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    let cart = Cart.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        calculateTotal()
    }

    // MARK:- setupUI
    func setupUI() {
        self.NavigationBarWithOutBackButton()
        self.addLeftBarButton()
    }

    func calculateTotal() {
        totalPriceLabel.text = cart.subtotalPrice
    }
    
    // MARK:- UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return cart.productsCount
        }
        return 0
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell

        if indexPath.section == 0 {
            return getItemCell(tableView: tableView, indexPath: indexPath)
        }


        return cell
    }

    // MARK:- CartTableViewCell
    func getItemCell(tableView: UITableView, indexPath: IndexPath) -> CartTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CartTableViewCell.identifier, for: indexPath) as! CartTableViewCell

        let cartProduct = cart.product(at: indexPath)
        cell.configure(product: cartProduct.0, cartItem: cartProduct.1)
        return cell
    }
}

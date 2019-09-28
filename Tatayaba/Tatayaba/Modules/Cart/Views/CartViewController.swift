//
//  CartViewController.swift
//  Tatayaba
//
//  Created by Admin on 15/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CartViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    let EditBtn = UIButton()
    let EditOkBtn = UIButton()
    var EditButton = String()
    let cart = Cart.shared

    private let checkoutSegue = "checkout_segue"


    @IBOutlet var cart_Tableview: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var subtotalPriceLabel: UILabel!

    //MARK:- Init
    override func viewDidLoad() {
        super.viewDidLoad()
        EditButton = "0"
        setupUI()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cart_Tableview.reloadData()
        cart_Tableview.separatorColor = .clear
        //totalButton.setTitle(cart.subtotalPrice, for: .normal)
    }

    func setupUI() {
         self.NavigationBarWithOutBackButton()
    }

    //MARK:- IBActions
    @IBAction func checkoutAction(_ sender: Any) {
        performSegue(withIdentifier: checkoutSegue, sender: nil)
    }

    //MARK:- Add / Remove Cell Actions
    func addOneMoreAction(indexPath: IndexPath) {
        let cartProduct = cart.product(at: indexPath)
        cart.increaseCount(cartItem: cartProduct.1)
        subtotalPriceLabel.text = cart.subtotalPrice
    }

    func removeOneAction(indexPath: IndexPath) {
        let cartProduct = cart.product(at: indexPath)
        cart.decreaseCount(cartItem: cartProduct.1)
        subtotalPriceLabel.text = cart.subtotalPrice
    }

    func removeItemAction(indexPath: IndexPath) {
        cart.removeProduct(at: indexPath)
        subtotalPriceLabel.text = cart.subtotalPrice
    }

}
 //Tableview
extension CartViewController {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.productsCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100

    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "CartCellIdentifier"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CartTableViewCell

        let cartProduct = cart.product(at: indexPath)
        cell.configure(product: cartProduct.0, cartItem: cartProduct.1)

        cell.onAddMoreClick = {
            self.addOneMoreAction(indexPath: indexPath)
            cell.updatePrice(product: cartProduct.0, cartItem: cartProduct.1)
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
}

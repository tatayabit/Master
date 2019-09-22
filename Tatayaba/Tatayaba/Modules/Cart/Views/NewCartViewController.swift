//
//  NewCartViewController.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/10/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class NewCartViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, CartViewModelDelegate {

    @IBOutlet var cartTableview: UITableView!
    @IBOutlet weak var totalPriceLabel: UILabel!
    @IBOutlet weak var totalTitleLabel: UILabel!

    let cart = Cart.shared
    let viewModel = CartViewModel()

    private let checkoutSegue = "checkout_segue"

    enum sectionType: Int {
        case item = 0, pricing
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        viewModel.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        calculateTotal()
        self.tabBarController?.tabBar.isHidden = false
    }

    // MARK:- setupUI
    func setupUI() {
        cartTableview.register(PriceTableViewCell.nib, forCellReuseIdentifier: PriceTableViewCell.identifier)
        self.NavigationBarWithOutBackButton()
    }

    func calculateTotal() {
        totalPriceLabel.text = cart.totalPrice
        viewModel.loadPricingListContent()
        let totalItemsText = "(" + String(cart.productsCount) + " " + "items".localized()+")"
        totalTitleLabel.attributedText = attributedTotalTitle(text: totalItemsText)
    }

    func attributedTotalTitle(text: String) -> NSAttributedString {
        let textVal = "Cart Total".localized() + " " + text

        let strokeTextAttributes = [
            NSAttributedString.Key.foregroundColor : UIColor(hexString: "221C35"),
            NSAttributedString.Key.font : UIFont.lightGotham(size: 11)
            ] as [NSAttributedString.Key : Any]

        let newStr = NSMutableAttributedString(string: textVal)
        newStr.addAttributes(strokeTextAttributes, range: (textVal as NSString).range(of: text))
        return newStr
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
        if viewModel.pricingList.count > 0 {
            return 2
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
            return viewModel.pricingList.count
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

    //MARK:- IBActions
    @IBAction func checkoutAction(_ sender: Any) {
        performSegue(withIdentifier: checkoutSegue, sender: nil)
    }
}

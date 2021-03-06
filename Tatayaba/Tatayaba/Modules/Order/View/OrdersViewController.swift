//
//  OrderViewController.swift
//  Tatayaba
//
//  Created by Admin on 24/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class OrdersViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, OrderTableViewCellDelegate {

    private let viewModel = OrdersViewModel()
    private let orderDetailsSegue = "order_details_segue"
    @IBOutlet weak var tableView: UITableView!
    let cartClass: CartPricingItems = CartPricingItems()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        setupListners()
    }


    func setupListners() {

        self.showLoadingIndicator(to: self.view)
        viewModel.onOrdersListLoad = {
            self.hideLoadingIndicator(from: self.view)
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }

        viewModel.onOrdersListLoadFailed = { error in
            self.hideLoadingIndicator(from: self.view)
            self.showErrorAlerr(title: Constants.Common.error, message: error.localizedDescription, handler: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        self.NavigationBarWithOutBackButton()
    }
}

//Tableview
extension OrdersViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (viewModel.orderCount > 0){
            return viewModel.orderCount
            
        }else{
            self.tableView.setEmptyMessage("No Orders".localized())
            return 0
        }
         
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "OrderTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! OrderTableViewCell

        cell.configure(order: viewModel.order(at: indexPath), indexPath: indexPath)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: orderDetailsSegue, sender: indexPath)
    }

    // MARK:- OrderTableViewCellDelegate
    func didSelectViewOrder(at indexPath: IndexPath) {
        performSegue(withIdentifier: orderDetailsSegue, sender: indexPath)
    }

    //MARK:- Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == orderDetailsSegue {
            let orderDetailsVC = segue.destination as! OrderDetailsViewController
            if let indexPath = sender as? IndexPath {
                orderDetailsVC.viewModel = viewModel.orderDetailsViewModel(at: indexPath)
            }
        }
    }
}

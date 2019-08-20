//
//  OrderViewController.swift
//  Tatayaba
//
//  Created by Admin on 24/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class OrdersViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    private let viewModel = OrdersViewModel()
    private let orderDetailsSegue = "order_details_segue"
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()

        // Do any additional setup after loading the view.

        setupListners()
    }


    func setupListners() {

        viewModel.onOrdersListLoad = {
            self.tableView.delegate = self
            self.tableView.dataSource = self
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        self.NavigationBarWithOutBackButton()
        self.addLeftBarButton()
    }
}

//Tableview
extension OrdersViewController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.orderCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "OrderTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! OrderTableViewCell

        cell.configure(order: viewModel.order(at: indexPath))

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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

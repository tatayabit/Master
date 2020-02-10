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
    var cellsCount: Int = 0
    var order: OrderModel = OrderModel()
    @IBOutlet weak var orderDetailstableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupListeners()
        orderDetailstableView.estimatedRowHeight = 100
        orderDetailstableView.rowHeight = UITableView.automaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NavigationBarWithBackButton()
    }
    
    func setupListeners() {
        self.showLoadingIndicator(to: self.view)
        viewModel?.onOrderLoad = {
            self.hideLoadingIndicator(from: self.view)
            if let currentOrder = self.viewModel?.order {
                self.order = currentOrder
                self.cellsCount = 3 + self.order.products.count
                self.orderDetailstableView.reloadData()
            }
        }
    }
}

extension OrderDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderMainInfoCell") as! OrderMainInfoCell
            cell.orderTitleID.text = "\("Order #:".localized()) \(order.identifier)"
            if let timeStampDouble = Double(order.timestamp) {
                let date = getDateFromTimeStamp(timeStamp: timeStampDouble)
                cell.orderDate.text = "\("Ordered on:".localized()) \(date)"
            }
            cell.trackingID.text = order.paymentInfo?.trackId
            cell.orderValue.text = "\(order.totalPrice)".formattedPrice
            return cell
        }
//        else if indexPath.row == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTrackCell") as! OrderTrackCell
//            return cell
//        }
        else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderDetailsCell") as! OrderDetailsCell
            cell.shippingValue.text = order.shippingCost
            if let timeStampDouble = Double(order.timestamp) {
                let date = getDateFromTimeStamp(timeStamp: timeStampDouble)
                cell.orderDate.text = "\(date)"
            }
            cell.paymentMethod.text = order.paymentMethod?.payment
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderAddressCell") as! OrderAddressCell
            cell.shippingAddress.text = order.shippingCity + ", " + order.shippingCountry
            
            cell.billingAddress.text = order.billingCity + ", " + order.billingCountry
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "OrderProductsCell") as! OrderProductsCell
            cell.configCell(product: order.products[indexPath.row - 3])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 150
        }
//        else if indexPath.row == 1 {
//            return 70
//        }
        else if indexPath.row == 1 {
            return 100
        } else if indexPath.row == 2 {
            return UITableView.automaticDimension
        } else {
            return 170
        }
        
    }
    
    func getDateFromTimeStamp(timeStamp : Double) -> String {
        
        let date = NSDate(timeIntervalSince1970: timeStamp)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "dd MMM YY, hh:mm a"
        // UnComment below to get only time
        //  dayTimePeriodFormatter.dateFormat = "hh:mm a"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        return dateString
    }
}

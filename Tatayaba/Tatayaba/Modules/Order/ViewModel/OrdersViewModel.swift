//
//  OrdersViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/6/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

class OrdersViewModel {

    private let ordersApiClient = OrdersAPIClient()

    private var ordersList = [OrderModel]()

    var orderCount: Int { return ordersList.count }

    /// This closure is being called once the categories api fetch
    var onOrdersListLoad: (() -> ())?

    //MARK:- Init
    init() {
        getAllOrders()
    }

    //MARK:- Api

    func getAllOrders() {
        ordersApiClient.getAllOrders(page: 0) { result in
            switch result {
            case .success(let response):
                guard let ordersResult = response else { return }
                guard let orders = ordersResult.orders else { return }

                self.ordersList = orders
                print(orders)

                if let newOrdersArrived = self.onOrdersListLoad {
                    newOrdersArrived()
                }
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }


    //MARK:- Orders data
    func order(at indexPath: IndexPath) -> OrderModel {
        guard ordersList.count > 0 else { return OrderModel() }
        return ordersList[indexPath.row]
    }

    //MARK:- OrderDetailsViewModel
    func orderDetailsViewModel(at indexPath: IndexPath) -> OrderDetailsViewModel {
        let order = self.order(at: indexPath)
        let orderDetailsVM = OrderDetailsViewModel(orderId: order.identifier)
        return orderDetailsVM
    }
}

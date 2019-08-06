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


    /// This closure is being called once the categories api fetch
    var onOrdersListLoad: (() -> ())?

    //MARK:- Init
    init() {
        getAllCategories()
    }

    //MARK:- Api

    func getAllCategories() {
        ordersApiClient.getAllOrders(page: 0) { result in
            switch result {
            case .success(let response):

                print(response)

                if let newOrdersArrived = self.onOrdersListLoad {
                    newOrdersArrived()
                }
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }


    //MARK:- Orders data

}

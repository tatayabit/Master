//
//  OrderDetailsViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 8/7/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Moya

class OrderDetailsViewModel {

    private let ordersApiClient = OrdersAPIClient()
    private var orderId: String

    /// This closure is being called once the categories api fetch
    var onOrderLoad: (() -> ())?

    //MARK:- Init
    init(orderId: String) {
        self.orderId = orderId
        getOrderDetails()
    }

    //MARK:- Api

    func getOrderDetails() {
        ordersApiClient.getOrder(orderId: orderId) { result in
            switch result {
            case .success(let response):

                print(response)

                if let orderDetailsArrived = self.onOrderLoad {
                    orderDetailsArrived()
                }
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }


    //MARK:- Orders data
}

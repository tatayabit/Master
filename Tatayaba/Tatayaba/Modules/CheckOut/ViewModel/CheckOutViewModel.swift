//
//  CheckOutViewModel.swift
//  Tatayaba
//
//  Created by Admin on 19/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct CheckOutViewModel {
    private let shippingApiClient = ShippingAPIClient()
    private let paymentApiClient = PaymentAPIClient()
    let cart = Cart.shared


    var subTotalValue: String { return cart.subtotalPrice }
    var shippingValue: String { return "1.000".formattedPrice }
    var totalValue: String { return String(cart.calculateSubTotal() + 1.000 + 0.500).formattedPrice }

    init() {
        getShippingMethods()
        getPaymentMethods()
    }

    //MARK:- Api
    func getShippingMethods() {
        shippingApiClient.getShippings { result in
            switch result {
            case .success(let response):
                guard let shippingResult = response else { return }
                guard let shippings = shippingResult.shippings else { return }

                print(shippings)

            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

    func getPaymentMethods() {
        paymentApiClient.getPayments { result in
            switch result {
            case .success(let response):
                guard let paymentResult = response else { return }
                guard let paymentMethods = paymentResult.paymentMethods else { return }

                print(paymentMethods)

            case .failure(let error):
                print("the error \(error)")
            }
        }
    }

    //MARK:- Prices Data

}

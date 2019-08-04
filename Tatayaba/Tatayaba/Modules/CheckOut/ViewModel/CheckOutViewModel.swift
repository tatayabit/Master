//
//  CheckOutViewModel.swift
//  Tatayaba
//
//  Created by Admin on 19/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//
import Moya

struct CheckOutViewModel {
    private let shippingApiClient = ShippingAPIClient()
    private let paymentApiClient = PaymentAPIClient()
    private let ordersApiClient = OrdersAPIClient()

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

    //MARK:- Placing Order
    func placeOrder(completion: @escaping (APIResult<PlaceOrderResult?, MoyaError>) -> Void) {
        ordersApiClient.CreateOrder(products: getProductsModel(), userId: "0", userData: getUserDataModel()) { result in
            switch result {
            case .success(let response):
                guard let placeOrderResult = response else { return }
                print(placeOrderResult)

            case .failure(let error):
                print("the error \(error)")
            }
            completion(result)
        }
    }

    func getProductsModel() -> [String: Any] {
        let cartItems = cart.cartItemsList()
        var productsParms = [String: Any]()

        for i in 0...cartItems.count - 1 {
            let cartItemX = cartItems[i]

            productsParms["\(i)"] = [
                "product_id": cartItemX.productId,
                "amount": "\(cartItemX.count)"
            ]
        }
        return productsParms
    }

    func getUserDataModel() -> [String: Any] {
        let dict = [
            "email":"guest48@example.com",
            "firstname": "Kareem",
            "lastname": "Test",
            "s_firstname": "S_Kareem",
            "s_lastname": "S_Test",
            "s_country": "KW",
            "s_city": "Kuwait",
            "s_state": "City",
            "s_zipcode": "80005",
            "s_address": "22 Main street",
            "b_firstname": "B_Kareem",
            "b_lastname": "B_Test",
            "b_country":"KW",
            "b_city": "Kuwait",
            "b_state": "City",
            "b_zipcode":"80005",
            "b_address": "22 Main street"
        ]
        return dict
    }

//    {
//    "email":"guest@example.com",
//    "firstname": "Guest",
//    "lastname": "Guest",
//    "s_firstname": "Guest",
//    "s_lastname": "Guest",
//    "s_country": "US",
//    "s_city": "Boston",
//    "s_state": "MA",
//    "s_zipcode": "02125",
//    "s_address": "44 Main street",
//    "b_firstname": "Guest",
//    "b_lastname": "Guest",
//    "b_country":"US",
//    "b_city": "Boston",
//    "b_state": "MA",
//    "b_zipcode":"02125",
//    "b_address": "44 Main street"
//    }

    //MARK:- CheckoutCompletedViewModel
    func checkoutCompletedViewModel(orderId: String) -> CheckoutCompletedViewModel {
        return CheckoutCompletedViewModel(orderId: orderId)
    }
}

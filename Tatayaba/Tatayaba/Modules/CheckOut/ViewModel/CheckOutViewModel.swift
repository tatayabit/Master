//
//  CheckOutViewModel.swift
//  Tatayaba
//
//  Created by Admin on 19/07/19.
//  Copyright © 2019 Shaik. All rights reserved.
//
import Moya

class CheckOutViewModel {
    private let shippingApiClient = ShippingAPIClient()
    private let paymentApiClient = PaymentAPIClient()
    private let ordersApiClient = OrdersAPIClient()

    let cart = Cart.shared

//    let kuwaitPaymentIds = ["12", "16", "1", "6"]


    var subTotalValue: String { return cart.subtotalPrice }
    var shippingValue: String { return "1.000".formattedPrice }
    var totalValue: String { return String(cart.calculateSubTotal() + 1.000 + 0.500).formattedPrice }
    var paymentMethods = [PaymentMethod]()
    
    var paymentId: String {
        let paymentId = cart.paymentMethod?.paymentId ?? "0"
        return paymentId
    }
    
    var isCashOnDelivery: Bool {
        return self.paymentId == Constants.PaymentTypes.cashOnDeliveryKuwait ||
        self.paymentId == Constants.PaymentTypes.cashOnDeliveryInternational
    }

    /// This closure is being called once the payement methods api fetch
    var onPaymentMethodsListLoad: (() -> ())?

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
//        paymentApiClient.getPayments { result in
//            switch result {
//            case .success(let response):
//                guard let paymentResult = response else { return }
//                guard let methods = paymentResult.paymentMethods else { return }
//                self.paymentMethods = methods.filter({ self.kuwaitPaymentIds.contains($0.paymentId) })

        if let methods = CountrySettings.shared.paymentMethods {
            self.paymentMethods = methods
            print(self.paymentMethods)
                       
            if self.paymentMethods.count > 0 {
                self.cart.paymentMethod = self.paymentMethods[0]
            }

           if let newPaymentsArrived = self.onPaymentMethodsListLoad {
               newPaymentsArrived()
           }
        }
               

//            case .failure(let error):
//                print("the error \(error)")
//            }
//        }
    }

    // MARK:- Payment Method
    func selectPaymentMethod(at indexPath: IndexPath) {
        let payment = paymentMethods[indexPath.row]
        cart.paymentMethod = payment
    }

    func isDefaultPaymentMethod(at indexPath: IndexPath) -> Bool {
        return cart.paymentMethod?.paymentId == self.paymentMethods[indexPath.row].paymentId
    }

    //MARK:- Placing Order
    func placeOrder(userData: User, completion: @escaping (APIResult<PlaceOrderResult?, MoyaError>) -> Void) {

        let userId = getUserId()
        let userData = userId == "0" ? getUserDataModel(user: userData) : nil

        let paymentId = cart.paymentMethod?.paymentId ?? "0"

        ordersApiClient.CreateOrder(products: getProductsModel(), userId: userId, userData: userData, paymentId: paymentId, oneClickBuy: cart.isOneClickBuy, code: cart.code) { result in
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

    func getUserId() -> String {
        let customer = Customer.shared
        if customer.loggedin {
            guard let user = customer.user else { return "0" }
            return user.identifier
        }
        return "0"
    }

    func getProductsModel() -> [String: Any] {
        let cartItems = cart.cartItemsList()
        var productsParms = [String: Any]()

        for i in 0...cartItems.count - 1 {
            let cartItemX = cartItems[i]

            var optionsParms = [[String: String]]()
            if let options = cartItemX.options {
                if options.count > 0 {
                   optionsParms = getProductOptions(cartOptions: options)
                }
            }
            
            var productPP = [String: Any]()
            productPP["product_id"] = cartItemX.productId
            productPP["amount"] = "\(cartItemX.count)"
            
            if optionsParms.count > 0 {
                productPP["product_options"] = optionsParms

            }
            productsParms["\(cartItemX.productId)"] = productPP
            
        }
        return productsParms
    }
    
    func getProductOptions(cartOptions: [CartItemOptions]) -> [[String: String]] {
        var optionsParms = [[String: String]]()
        for optionSection in cartOptions {
            optionsParms.append([optionSection.optionId: optionSection.variantId])
        }
        return optionsParms
    }

    func getUserDataModel(user: User) -> [String: Any] {

        let dict = [
            "email":user.email,
            "firstname": user.firstname,
            "lastname": user.firstname,
            "s_firstname": "S_\(user.firstname)",
            "s_lastname": "S_\(user.firstname)",
            "s_country": "KW",
            "s_city": user.shippingCity,
            "s_state": "City",
            "s_zipcode": "80005",
            "s_address": user.shippingAddress,
            "b_firstname": "B_\(user.firstname)",
            "b_lastname": "B_\(user.firstname)",
            "b_country":"KW",
            "b_city": user.shippingCity,
            "b_state": "City",
            "b_zipcode":"80005",
            "b_address": user.shippingAddress
        ]
        return dict
    }

    //MARK:- CheckoutCompletedViewModel
    func checkoutCompletedViewModel(orderId: String) -> CheckoutCompletedViewModel {
        return CheckoutCompletedViewModel(orderId: orderId)
    }
    
    func paymentWebViewModel(orderResult: PlaceOrderResult) -> PaymentWebViewModel {
        return PaymentWebViewModel(orderResult: orderResult)
    }
}

extension Constants {
    struct PaymentTypes {
        static let cashOnDeliveryKuwait = "6"
        static let cashOnDeliveryInternational = "14"
    }
}

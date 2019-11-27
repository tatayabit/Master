//
//  CheckoutCompletedViewModel.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/29/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct CheckoutCompletedViewModel {
    var orderIdText: String { return "ORDER # \(orderId)" }
    var orderDate: String { return Date.orderFormattedDate() }
    var paymentDetails: String {
        var details = ""
        if let ref_no = resultData["ref_no"] as? String {
            details.append("Ref No.: " + ref_no + "\n")
        }
        if let transactionId = resultData["trans_id"] as? String {
            details.append("Transaction ID: " + transactionId + "\n")
        }
        if let paymentId = resultData["payment_id"] as? String {
            details.append("Payment ID: " + paymentId + "\n")
        }
        return details
    }
    
    private var orderId: String
    private var resultData: [String: Any]


    init(orderId: String, resultData: [String: Any] = [String: Any]()) {
        self.orderId = orderId
        self.resultData = resultData
        self.clearCart()
    }
    
    func clearCart() {
        Cart.shared.reset()
    }
}

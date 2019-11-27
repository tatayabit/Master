//
//  PaymentWebViewModel.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/20/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

class PaymentWebViewModel: DataBase64Decodable {
    
    var orderResult: PlaceOrderResult
    private var resultData = [String: Any]()
    

    init(orderResult: PlaceOrderResult) {
        self.orderResult = orderResult
    }
    
    // MARK :- Response Validation
    func isPaymentSuccess(with url: URL) -> Bool {
        if let parms = url.queryParameters {
            if let captured = parms["ttm_pgstats"] {
                if captured.lowercased() == "captured" {
                    if let ttmData = parms["ttm_data"] {
                        
                        print(json(from: base64Decoded(encodedString: ttmData)))
                        self.resultData = json(from: base64Decoded(encodedString: ttmData))
                    }
                    return true
                }
            }
//            https://dev2.tatayab.com/?ttm_pgstats=CANCELED&ttm_msg=
        }
        return false
    }
    
    func isPaymentFailed(with url: URL) -> Bool {
            if let parms = url.queryParameters {
                if let captured = parms["ttm_pgstats"] {
                    if captured.lowercased() == "cancelled" || captured.lowercased() == "not+captured" {
                        return true
                    }
                }
    //            https://dev2.tatayab.com/?ttm_pgstats=CANCELED&ttm_msg=
            }
            return false
        }
    
    //MARK:- CheckoutCompletedViewModel
    func checkoutCompletedViewModel() -> CheckoutCompletedViewModel {
        return CheckoutCompletedViewModel(orderId: "\(self.orderResult.orderId)", resultData: self.resultData)
    }
    
    // MARK :- Cart
    func clearCart() {
        Cart.shared.reset()
    }
}

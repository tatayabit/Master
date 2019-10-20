//
//  PaymentWebViewModel.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/20/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

struct PaymentWebViewModel {
    
    var orderResult: PlaceOrderResult
    

    init(orderResult: PlaceOrderResult) {
        self.orderResult = orderResult
    }
    
    // MARK :- Response Validation
    func isPaymentSuccess(with url: URL) -> Bool {
        if let parms = url.queryParameters {
            if let captured = parms["ttm_pgstats"] {
                if captured.lowercased() == "captured" {
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
    
    // MARK :- Cart
    func clearCart() {
        Cart.shared.reset()
    }
}

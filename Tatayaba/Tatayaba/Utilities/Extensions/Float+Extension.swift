//
//  Float+Extension.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 11/21/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

extension Float {
    var roundedTwoDecimal: Float {
        let roundedValue = (self * 100).rounded() / 100
        return roundedValue
    }
    
    func roundedTo(decimals: Int) -> Float {
        let divisor = pow(10.0, Float(decimals))
        return (self * divisor).rounded() / divisor
    }
    
    func roundedFormat(decimals: Int) -> Float {
//        0.00000000001
        let dValue = Double(exactly: self) ?? 0.00
//        dValue?.rounded(.toNearestOrAwayFromZero)
        var oldValue = Decimal(dValue)
        var decimaV = Decimal()
        let places = decimals > 2 ? 2 : decimals
        NSDecimalRound(&decimaV, &oldValue, places, NSDecimalNumber.RoundingMode.plain)

        let fValue = Float(String(format: "%.\(places)f", self)) ?? 0.00
//        Float()
        
        return NSDecimalNumber(decimal: decimaV).floatValue//fValue
    }
}

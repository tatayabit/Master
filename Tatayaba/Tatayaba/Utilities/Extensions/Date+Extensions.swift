//
//  Date+Extensions.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/25/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}

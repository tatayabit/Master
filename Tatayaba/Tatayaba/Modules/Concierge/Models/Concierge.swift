//
//  Concierge.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/24/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

struct Concierge {
    var perfumeName: String
    var comment: String
    var customerName: String
    var phone: String
    var countryCode: String
    var imageData: String

    init(perfumeName: String, comment: String = "", customerName: String = "", phone: String, countryCode: String = "", imageData: String = "") {
        self.perfumeName = perfumeName
        self.comment = comment
        self.customerName = customerName
        self.phone = phone
        self.countryCode = countryCode
        self.imageData = imageData
    }
}

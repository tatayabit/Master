//
//  String+Extensions.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/9/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
}

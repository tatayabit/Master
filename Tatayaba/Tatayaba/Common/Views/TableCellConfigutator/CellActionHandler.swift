//
//  CellActionHandler.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import Foundation

enum CellAction: Hashable {

    case didSelect
    case willDisplay

    var hashValue: Int {
        switch self {
        case .didSelect:
            return 0
        case .willDisplay:
            return 1
        }
    }

    static func ==(lhs: CellAction, rhs: CellAction) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}

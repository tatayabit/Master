//
//  HeaderViewItem.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 10/12/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

protocol HeaderItemProtocol {
    var rowCount: Int { get }
    var collapsed: Bool { get set}
    var isCollapsible: Bool { get }
}

class HeaderItem: HeaderItemProtocol {
    var rowCount: Int
    var collapsed: Bool
    var isCollapsible: Bool
    
    init(rowCount: Int, collapsed: Bool, isCollapsible: Bool) {
        self.rowCount = rowCount
        self.collapsed = collapsed
        self.isCollapsible = isCollapsible
    }
}

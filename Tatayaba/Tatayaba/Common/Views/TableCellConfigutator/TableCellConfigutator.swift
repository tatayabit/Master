//
//  TableCellConfigutator.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class TableCellConfigutator<CellType: ConfigurableCell, CellDataType: Hashable>: CellConfigurator where CellType.CellDataType == CellDataType, CellType: UITableViewCell {

    static var reuseId: String { return CellType.reuseIdentifier }
    static var rowHeight: CGFloat {
        if let height = CellType.height {
            return height
        }
        return 44
    }

    let item: CellDataType

    init(item: CellDataType) {
        self.item = item
    }

    func configure(cell: UIView, eventable: Eventable?) {
        (cell as! CellType).configure(data: item, eventable: eventable)
    }


}

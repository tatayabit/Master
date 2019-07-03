//
//  TableCellActionProxy.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class TableCellActionProxy {

    private var actions = [String: ((CellConfigurator, UIView) -> Void)]()

    func invoke(action: CellAction, cell: UIView, configurator: CellConfigurator) {
        let key = "\(action.hashValue)\(type(of: configurator).reuseId)"
        if let action = actions[key] {
            action(configurator, cell)
        }
    }


    @discardableResult
    func on<CellType, CellDataType>(action: CellAction,
                                    handler: @escaping ((TableCellConfigutator<CellType, CellDataType>, CellType) -> Void )) -> Self {
        let key = "\(action.hashValue)\(CellType.reuseIdentifier)"
        actions[key] = { (configurator, cell) in
            handler(configurator as! TableCellConfigutator<CellType, CellDataType>, cell as! CellType)
        }

        return self
    }
}

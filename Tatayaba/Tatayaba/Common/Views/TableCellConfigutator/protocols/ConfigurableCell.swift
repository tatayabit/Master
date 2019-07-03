//
//  ConfigurableCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/2/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

protocol ConfigurableCell {
    associatedtype CellDataType
    func configure(data: CellDataType, eventable: Eventable?)
    static var height: CGFloat? { get }
    static var reuseIdentifier: String { get }
}

extension ConfigurableCell {
    static var reuseIdentifier: String { return String(describing: Self.self) }
}


protocol CellConfigurator {
    static var reuseId: String { get }
    static var rowHeight: CGFloat { get }
    func configure(cell: UIView, eventable: Eventable?)
}

protocol Eventable {}
protocol AutoFillProtocol: Eventable {
    func fill(autoFillText: String)
}

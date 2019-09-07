//
//  TITextField.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 9/7/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

@IBDesignable
class TITextField: UITextField {
    @IBInspectable var insetX: CGFloat = 0
    @IBInspectable var insetY: CGFloat = 0

    // placeholder position
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }

    // text position
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: insetX, dy: insetY)
    }
}

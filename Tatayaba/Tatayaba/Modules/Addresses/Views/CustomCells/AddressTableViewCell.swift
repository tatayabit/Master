//
//  AddressTableViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/31/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class AddressTableViewCell: UITableViewCell {

    @IBOutlet weak var addressNameLabel: UILabel!
    @IBOutlet weak var addressDetailsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure() {
        self.addressNameLabel.text = ""
        self.addressDetailsLabel.text = ""
    }
}

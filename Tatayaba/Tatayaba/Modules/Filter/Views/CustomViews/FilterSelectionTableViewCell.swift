//
//  FilterSelectionTableViewCell.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 1/15/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//

import UIKit

class FilterSelectionTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(supplier: Supplier, selected: Bool) {
        self.nameLabel.text = supplier.name
        let imageIcon = selected ? "selected_icon" : "unselected_icon"
        self.checkMarkImageView.image = UIImage(named: imageIcon)
    }
    
    func configure2(text: String, selected: Bool) {
        self.nameLabel.text = text
        let imageIcon = selected ? "selected_icon" : "unselected_icon"
        self.checkMarkImageView.image = UIImage(named: imageIcon)
    }
    
}

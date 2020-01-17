//
//  FilterCategoryTableViewCell.swift
//  Tatayaba
//
//  Created by Kareem Mohammed on 1/17/20.
//  Copyright © 2020 Tatayab. All rights reserved.
//

import UIKit

class FilterCategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var checkMarkImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(category: Category, selected: Bool) {
        self.nameLabel.text = category.name
        let imageIcon = selected ? "selected_icon" : "unselected_icon"
        self.checkMarkImageView.image = UIImage(named: imageIcon)
    }
    
}

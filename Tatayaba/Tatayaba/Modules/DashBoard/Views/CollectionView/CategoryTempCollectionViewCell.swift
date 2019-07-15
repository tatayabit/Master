//
//  CategoryTempCollectionViewCell.swift
//  Tatayaba
//
//  Created by Kareem Kareem on 7/10/19.
//  Copyright © 2019 Shaik. All rights reserved.
//

import UIKit

class CategoryTempCollectionViewCell: UICollectionViewCell {

    @IBOutlet var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(category: Category) {
        nameLabel.text = category.name
    }
}
